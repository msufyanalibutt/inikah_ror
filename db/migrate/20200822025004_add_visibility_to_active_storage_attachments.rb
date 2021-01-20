class AddVisibilityToActiveStorageAttachments < ActiveRecord::Migration[6.0]
  def change
  	add_column :active_storage_attachments, :visibility, :boolean, default: false
  end
end
