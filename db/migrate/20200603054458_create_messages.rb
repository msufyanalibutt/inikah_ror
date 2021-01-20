class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string   :note
      t.integer  :sender_id
      t.references :conversation
    end
  end
end
