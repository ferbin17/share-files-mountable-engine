class DeleteAlertMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'sharefilesapp', backtrace: true

  def perform(file_sender_id)
    file_sender = ShareFilesApp::FileSender.active.find_by_id(file_sender_id)
    if file_sender.present?
      ShareFilesApp::UploadMailer.with(file_sender: file_sender).sender_delete_alert.deliver_now
      ShareFilesApp::UploadMailer.with(file_sender: file_sender).receiver_delete_alert.deliver_now
    end
  end 
end