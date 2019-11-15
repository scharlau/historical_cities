class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :Name
      t.string :OtherName
      t.string :Country
      t.decimal :Latitude
      t.decimal :Longitude
      t.integer :Certainty
      t.integer :Year
      t.integer :Population
      t.integer :CityId

      t.timestamps
    end
  end
end
