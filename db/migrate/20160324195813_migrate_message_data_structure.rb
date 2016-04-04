class MigrateMessageDataStructure < ActiveRecord::Migration

  def change
    remove_column :messages, :subject
    remove_column :messages, :body
    add_column :messages, :conversation_id, :integer
    rename_table :messages, :inquiries
  end

end