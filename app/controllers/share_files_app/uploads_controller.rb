require_dependency "share_files_app/application_controller"

module ShareFilesApp
  class UploadsController < ApplicationController
    def index
      sender_id = cookies.permanent[:sender_id].present? ? cookies.permanent[:sender_id] : nil
      @sender = ShareFilesApp::User.find_by_id(sender_id)
      @file_sender = ShareFilesApp::FileSender.new(sender_id: @sender.try(:id))
    end
  
    def set_users
      @file_sender = ShareFilesApp::FileSender.new(total_files: params[:total_files], total_file_size: params[:total_file_size])
      set_email_ids
      if @file_sender.save
        render json: { id: @file_sender.id }
      else
        render json: { error: @file_sender.errors }, status: 422
      end
    end
  
    def create
      @file_sender = ShareFilesApp::FileSender.active.find_by_id(params[:file_sender_id])
      if @file_sender.present?
        filename = params[:filename]
        uuid = SecureRandom.uuid
        ext  = File.extname(filename) if filename.present?
        dir  = Rails.root.join('tmp', 'upload').to_s
        FileUtils.mkdir_p(dir) unless File.exist?(dir)
        @upload = @file_sender.uploads.new(filename: filename, file_size: params[:file_size], path: File.join(dir, "#{uuid}#{ext}"))
        if @file_sender.save
          download_url = url_for(controller: :downloads, action: :show, id: @file_sender.uuid)
          @file_sender.update(download_url: download_url)
          render json: { id: @upload.id, filename: @upload.filename, uploaded_size: @upload.uploaded_size, file_size: @upload.file_size }
        else
          render json: { error: @upload.errors }, status: 422
        end
      else
        render json: {error: "File Sender not found"}, status: 422
      end
    end
  
    def chunk_create
      file = params[:upload]
      @upload = ShareFilesApp::Upload.find_by(id: params[:id]) 
      @file_sender = @upload.file_sender
      @upload.uploaded_size += file.size
      if @upload.save
        File.open(@upload.path, 'ab') { |f|
          f.write(file.read)
        }
        if @upload.uploaded_size == @upload.file_size
          PaperclipCreateWoker.perform_async(@upload.id)
        end
        render json: { id: @upload.id, filename: @upload.filename, uploaded_size: @upload.uploaded_size, file_size: @upload.file_size }
      else
        render json: { error: @upload.errors }, status: 422
      end
    end
  
    def cancel_upload
      if params[:file_sender_id].present?
        @file_sender = ShareFilesApp::FileSender.active.find_by_id(params[:file_sender_id])
      elsif params[:file_id].present?
        @file = ShareFilesApp::Upload.find_by_id(params[:file_id])
      else
      end
      result =
        if @file_sender.present?
          @file_sender.destroy
        elsif @file.present?
          @file_sender = @file.file_sender
          if @file.destroy
            @file_sender.update(total_file_size: @file_sender.total_file_size - @file.file_size, total_files: @file_sender.total_files - 1)
          end
        else
          false
        end
      render json: { result:  result}, status: 200
    end
  
    private
      def set_email_ids
        unless @file_sender.sender_id.present?
          @sender = ShareFilesApp::User.find_or_create_by(email_id: params[:sender_email])
          @file_sender.update(sender_id: @sender.id)
          cookies.permanent[:sender_id] = @sender.id  
        end
        unless @file_sender.receiver_id.present?
          @receiver = ShareFilesApp::User.find_or_create_by(email_id: params[:receiver_email])
          @file_sender.update(receiver_id: @receiver.id)
        end
      end
  end
end
