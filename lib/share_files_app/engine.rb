module ShareFilesApp
  class Engine < ::Rails::Engine
    isolate_namespace ShareFilesApp

    initializer "share_files_app.assets.precompile" do |app|
      app.config.assets.precompile << "share_files_app_manifest.js"
    end
  end
end
