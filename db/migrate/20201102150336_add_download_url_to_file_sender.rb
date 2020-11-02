class AddDownloadUrlToFileSender < ActiveRecord::Migration[6.0]
  def change
    add_column :share_files_app_file_senders, :download_url, :string
  end
end
