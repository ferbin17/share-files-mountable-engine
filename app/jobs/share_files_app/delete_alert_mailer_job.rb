module ShareFilesApp
  class DeleteAlertMailerJob < ApplicationJob
    queue_as :default

    def perform
      ShareFilesApp::DeleteAlertJob.perform
    end
  end
end
