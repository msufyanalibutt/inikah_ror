class AddTimespanInMessages < ActiveRecord::Migration[6.0]
  def change
  	add_timestamps :messages, default: Time.zone.now
    change_column_default :messages, :created_at, nil
		change_column_default :messages, :updated_at, nil
  end
end
