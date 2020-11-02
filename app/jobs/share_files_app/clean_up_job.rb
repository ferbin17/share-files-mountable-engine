module ShareFilesApp
  require 'rake'
  Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
  class CleanUpJob < ApplicationJob
    queue_as :default

    def perform
      Rake::Task["share_file:clean_up_file_senders"].invoke
    end
  end
end
