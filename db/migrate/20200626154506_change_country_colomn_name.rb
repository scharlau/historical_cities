class ChangeCountryColomnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :cities, :country, :countryName
  end
end
