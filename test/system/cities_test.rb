require "application_system_test_case"
require 'rake'

class CitiesTest < ApplicationSystemTestCase
  setup do
   # assign variable to the task, then invoke it
   task = Rake::Task['cities:seed_basic_cities']
   task.invoke
  end

# removing 'creating a city', and 
# 'updating a city', and 'destroying a city' tests 
# as we're not changing any data.

# INSTEAD, we need tests to navigate the pages and confirm
# that they load correctly.

  test "visiting the index" do
   # visit cities_url
    visit '/'
    assert_selector "h1", text: "Cities ordered by Year"

    click_on 'Countries'
    assert_selector "h1", text: "Cities ordered by Country"   

    click_on 'City Names'
    assert_selector "h1", text: "Cities by Name"  
    
    click_on 'Show Aachen'
    assert_selector "h1", text: "City Search Result"  

    click_on 'Show 1900'
    assert_selector "h1", text: "Aachen"  

    click_on 'City List'
    assert_selector "h1", text: "A List of Cities"  
  end
end
