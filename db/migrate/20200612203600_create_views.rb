class CreateViews < ActiveRecord::Migration[6.0]
  def change
    create_table :views do |t|
      t.integer :user_id,   index: true
      t.integer :viewer_id, index: true
      t.boolean :seen,      default: false

      t.timestamps
    end
  end
end
