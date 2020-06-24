require "application_system_test_case"
require 'rake'

class CitiesTest < ApplicationSystemTestCase
  setup do
   Rake::Task['cities:seed_basic_cities']
  end


# removing 'creating a city', and 
# 'updating a city', and 'destroying a city' tests 
# as we're not changing any data.

# INSTEAD, we need tests to navigate the pages and confirm
# that they load correctly.

  test "visiting the index" do
    visit cities_url
    assert_selector "h1", text: "Cities"
  end
end
