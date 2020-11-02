require "share_files_app/engine"

module ShareFilesApp

  if File.exist?("#{ShareFilesApp::Engine.root}/config/app_config.yml")
    AppConfig = Psych.safe_load(File.open("#{ShareFilesApp::Engine.root}/config/app_config.yml"), aliases: true)
  end
end
