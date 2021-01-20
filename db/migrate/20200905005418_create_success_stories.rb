class CreateSuccessStories < ActiveRecord::Migration[6.0]
  def change
    create_table :success_stories do |t|
    	t.string   :name
      t.text     :description
      t.boolean  :approved
      t.references :user

      t.timestamps
    end
  end
end
