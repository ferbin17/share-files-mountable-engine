require_dependency "share_files_app/application_controller"

module ShareFilesApp
  class WelcomeController < ApplicationController
    def index
      p url_for(controller: :downloads, action: :download, id: "ss")
    end
  end
end
