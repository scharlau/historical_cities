class ChangeCountryToInteger < ActiveRecord::Migration[6.0]
  def change 
    add_reference :cities, :country, references: :country, index: true

  end
end
