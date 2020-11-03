module ShareFilesApp
  class DeleteAlertJob < ApplicationJob
    queue_as :sharefilesapp

    def perform
      count = 0
      ShareFilesApp::FileSender.active.delete_mail_not_sent.each do |file_sender|
        flag = (file_sender.expiry_date >= Time.now + 1.days) && (file_sender.expiry_date <= Time.now + 2.days)
        if flag
          time = file_sender.expiry_date - 24.hours
          if time <= Time.now
            time = Time.now + 5.minutes
          end
          count += 1
          DeleteAlertMailWorker.perform_at(time, file_sender.id)
        end
      end
      log = Logger.new('log/share_file_app/delete_alert_sender.log')
      log.info "Scheduled #{count} delete alert jobs"    
    end
  end
end
