class UpdatesInUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :age,            :integer, using: 'age::integer'
    change_column :users, :annual_income,  :integer, using: 'annual_income::integer'
    change_column :users, :height,         :float,   using: 'height::float'
    change_column :users, :weight,         :float,   using: 'weight::float'
  end
end
