require 'creek'
namespace :cities do
  desc "parse cities to database as one table"
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
  desc "parse cities for heroku"
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

  #task to generate JSON file for use in bar chart race
  # we get objects, but just need year in an array, and then want 
  # it in order by years.
  desc "create JSON file to use in bar chart race"
  task barchart_json: :environment do
    start_years = City.select(:year).distinct
    start_years = start_years.to_ary
    years = []
    start_years.each do |y|
       years << y.year
    end
    years.sort!
    years_count = 0
    years_size = years.size
    
    file_folder = Rails.root.join('public')
    # File.open(file_folder.join("barchartcities.json"),mode ="r") do |f1|

    #   puts "barchartcities: "
    #   while line = f1.gets
    #     puts line
    #   end
    # end
    #
    #  need to add counter for the loops to add comma after each loop, 
    #  but not on the last one
    File.open(file_folder.join("barchartcities.json"),"w") do |f2|
      puts "opened file to write"
      f2.write "["
      years.each do |year|
        f2.write "{\"year\":"
        this_year = year
        f2.write this_year 
        f2.write ",\"entries\":[" 
        # gather up cities and populations for this year
        city_year = City.where('year = ?', "#{year}")
        cy_count = 0
        cy_size = city_year.size
        city_year.each do |cy|
          f2.write "{\"name\":\"#{cy.name}\", \"value\":#{cy.population}}"
          cy_count = cy_count+1
          if cy_count == cy_size
            f2.write ""
          else
          f2.write ","
          end
        end
        years_count = years_count+1
        if years_count == years_size
          f2.write "]}"
        else
        f2.write "]},"
        end
      end
      
      f2.write"]"
      puts "closing file"
    end
 

  end

end
