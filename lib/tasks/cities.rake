require 'creek'
namespace :cities do
  desc "pase cities to database as one table"
  task seed_basic_cities: :environment do

    #drio the old table data before importing the new one
    City.destroy_all

    workbook = Creek::Book.new 'lib/assets/urbanspatial-hist-urban-pop-3700bc-ad2000.xlsx'
    sheet = workbook.sheets[2]

    #create model instances with the data
    sheet.simple_rows.each do |row|
      puts row 
      # need to extract values from row to populate instance - puts statement was to test this
      row_cells = row.values
      #puts "row cells: " + row_cells.to_s
      City.create!(
      Name: row_cells[1],
      OtherName: row_cells[2],
      Country: row_cells[3],
      Latitude: row_cells[4],
      Longitude: row_cells[5],
      Certainty: row_cells[6],
      Year: row_cells[7],
      Population: row_cells[8],
      CityId: row_cells[9]
      )
      
    end

  end

end
