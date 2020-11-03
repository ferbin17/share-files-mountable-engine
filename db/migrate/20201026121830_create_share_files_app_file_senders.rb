class CreateShareFilesAppFileSenders < ActiveRecord::Migration[6.0]
  def change
    create_table :share_files_app_file_senders do |t|
      t.string :uuid
      t.integer :total_file_size, default: 0
      t.integer :uploaded_size, default: 0
      t.datetime :expiry_date
      t.boolean :sender_mail_sent, default: false
      t.boolean :receiver_mail_sent, default: false
      t.boolean :sender_delete_mail_sent, default: false
      t.boolean :receiver_delete_mail_sent, default: false
      t.integer :sender_id
      t.integer :receiver_id 
      t.boolean :is_expired, default: false
      t.integer :total_files, default: 0
      t.integer :uploaded_files, default: 0 
    end
  end
end