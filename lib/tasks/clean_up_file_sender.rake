namespace :share_file do
  desc 'Clean up expired or broken filesenders'
  task :clean_up_file_senders => :environment do
    log = Logger.new('log/share_file_app/clean_up_file_senders.log')
    start_time = Time.now
    log.info "Clean up started at #{start_time}"
    count = (ShareFilesApp::FileSender.where("expiry_date < '#{Time.now}'").destroy_all).count
    log.info "Cleaned #{count} expired filesenders"
    broken_uploads = ShareFilesApp::Upload.where("uploaded_size != file_size and updated_at < '#{Time.now + 1.hours}'")
    count = 0
    broken_uploads.each do |upload|
      upload.file_sender.destroy
      count += 1
    end
    log.info "Cleaned #{broken_uploads.count} broken filesenders (#{count} uploads)"
    end_time = Time.now
    duration = end_time - start_time
    log.info "Clean up ended at #{end_time}"    
    log.info "Clean up total time duration #{duration/60} mins"
  end
end