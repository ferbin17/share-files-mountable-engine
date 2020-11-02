Rails.application.routes.draw do
  mount ShareFilesApp::Engine => "/share_files_app"
end
