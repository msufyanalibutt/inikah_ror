class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id,  index: true
      t.integer :liker_id, index: true
      t.boolean :seen,     default: false

      t.timestamps
    end
  end
end
