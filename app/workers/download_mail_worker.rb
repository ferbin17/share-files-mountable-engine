class DownloadMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'sharefilesapp', backtrace: true
    
  def perform(file_sender_id)
    file_sender = ShareFilesApp::FileSender.active.find_by_id(file_sender_id)
    if file_sender.present?
      sender = file_sender.sender
      sender.update(upload_count: sender.upload_count + file_sender.total_files.to_i)
      ShareFilesApp::UploadMailer.with(file_sender: file_sender).send_download_link.deliver_now
      ShareFilesApp::UploadMailer.with(file_sender: file_sender).send_success_mail.deliver_now
    end
  end
end