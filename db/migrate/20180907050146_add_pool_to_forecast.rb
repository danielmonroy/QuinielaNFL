class AddPoolToForecast < ActiveRecord::Migration[5.2]
  def change
    add_reference :forecasts, :pool, foreign_key: true
  end
end
