class ChangeColumnNamesInCities < ActiveRecord::Migration[6.0]
  def change
    rename_column :cities, :Name, :name
    rename_column :cities, :OtherName, :otherName
    rename_column :cities, :Country, :country
    rename_column :cities, :Latitude, :latitude
    rename_column :cities, :Longitude, :longitude
    rename_column :cities, :Certainty, :certainty
    rename_column :cities, :Year, :year
    rename_column :cities, :Population, :poplulation
    rename_column :cities, :CityId, :cityId
  end
end
