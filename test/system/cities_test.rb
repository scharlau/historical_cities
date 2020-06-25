require "application_system_test_case"
require 'rake'

class CitiesTest < ApplicationSystemTestCase
  setup do
   # assign variable to the task, then invoke it
   task = Rake::Task['cities:seed_heroku']
   task.invoke
  end

# removing 'creating a city', and 
# 'updating a city', and 'destroying a city' tests 
# as we're not changing any data.

# INSTEAD, we need tests to navigate the pages and confirm
# that they load correctly.
# use minitest assertions for selectors
# use capybara assertion to confirm text is on the page

  test "visiting the index" do
   # visit cities_url
    visit '/'
    assert_selector "h1", text: "Cities ordered by Year"
    assert page.has_content?('Show -3700')

    click_on 'Countries'
    assert_selector "h1", text: "Cities ordered by Country" 
    assert page.has_content?('Kabul_34.5_69.2')  

    click_on 'City Names'
    assert_selector "h1", text: "Cities by Name"  
    
    click_on 'Show Aachen'
    assert_selector "h1", text: "City Search Result"  

    click_on 'Show 1900'
    assert_selector "h1", text: "Aachen"  
    assert page.has_content?('Aix-la-Chapelle')

    click_on 'City List'
    assert_selector "h1", text: "A List of Cities"  
  end
end
