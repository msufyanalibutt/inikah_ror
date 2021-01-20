class CreateProfileRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_requests do |t|
    	t.integer :user_id,   index: true
      t.integer :requester_id, index: true
      t.boolean :approved,      default: false

      t.timestamps
    end
  end
end
