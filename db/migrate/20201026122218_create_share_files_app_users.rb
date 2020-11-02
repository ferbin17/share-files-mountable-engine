class CreateShareFilesAppUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :share_files_app_users do |t|
      t.string :email_id
      t.integer :upload_count, default: 0
      t.integer :sent_count, default: 0
      t.boolean :sender_delete_mail_sent, default: false
      t.boolean :receiver_delete_mail_sent, default: false
      t.timestamps
    end
  end
end