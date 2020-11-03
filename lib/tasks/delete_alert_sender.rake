namespace :share_file do
  desc 'Send delete alert for uploads'
  task :delete_alert_sender => :environment do
    log = Logger.new('log/share_file_app/delete_alert_sender.log')
    start_time = Time.now
    log.info "Delete alert sender started at #{start_time}"
    ShareFilesApp::DeleteAlertJob.perform_now
    end_time = Time.now
    duration = end_time - start_time
    log.info "Delete alert sender ended at #{end_time}"    
    log.info "Delete alert sender total time duration #{duration/60} mins"
  end
end