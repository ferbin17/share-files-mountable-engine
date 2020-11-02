class AddAttaachmentsToUploads < ActiveRecord::Migration[6.0]
  def change
    add_attachment :share_files_app_uploads, :upload_file
  end
end
