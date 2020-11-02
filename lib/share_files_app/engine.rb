module ShareFilesApp
  class Engine < ::Rails::Engine
    isolate_namespace ShareFilesApp

    # initializer "engine_name.assets.precompile" do |app|
    #   app.config.assets.precompile += %w(share_files_app/application.js share_files_app/application.css)
    # end
    
    # Initializer to combine this engines static assets with the static assets of the hosting site.
   #  initializer "static assets" do |app|
   #   app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
   # end
  end
end
