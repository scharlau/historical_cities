require 'creek'
namespace :cities do
  desc "pase cities to database as one table"
  task seed_basic_cities: :environment do

    #destroy the old table data before importing the new one
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
      name: row_cells[1],
      otherName: row_cells[2],
      country: row_cells[3],
      latitude: row_cells[4],
      longitude: row_cells[5],
      certainty: row_cells[6],
      year: row_cells[7],
      population: row_cells[8],
      cityId: row_cells[9]
      )
      
    end

  end

  # heroku has a limit of 10k records so 
  # we'll modify this method and spreadsheet to stay within limit
  desc "pase cities for heroku"
  task seed_heroku: :environment do

    #destroy the old table data before importing the new one
    # City.destroy_all

    workbook = Creek::Book.new 'lib/assets/urbanspatial-heroku.xlsx'
    sheet = workbook.sheets[2]

    #create model instances with the data
    sheet.simple_rows.each do |row|
      puts row 
      # need to extract values from row to populate instance - puts statement was to test this
      row_cells = row.values
      #puts "row cells: " + row_cells.to_s
      City.create!(
      name: row_cells[1],
      otherName: row_cells[2],
      country: row_cells[3],
      latitude: row_cells[4],
      longitude: row_cells[5],
      certainty: row_cells[6],
      year: row_cells[7],
      population: row_cells[8],
      cityId: row_cells[9]
      )
      
    end

  end

end
