class ChangeColumnPopulationInCities < ActiveRecord::Migration[6.0]
  def change
    rename_column :cities, :poplulation, :population
  end
end
