class AddEditableToForecast < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :editable, :boolean, default: true
  end
end
