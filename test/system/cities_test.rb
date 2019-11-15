require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  setup do
    @city = cities(:one)
  end

  test "visiting the index" do
    visit cities_url
    assert_selector "h1", text: "Cities"
  end

  test "creating a City" do
    visit cities_url
    click_on "New City"

    fill_in "Certainty", with: @city.Certainty
    fill_in "Cityid", with: @city.CityId
    fill_in "Country", with: @city.Country
    fill_in "Latitude", with: @city.Latitude
    fill_in "Longitude", with: @city.Longitude
    fill_in "Name", with: @city.Name
    fill_in "Othername", with: @city.OtherName
    fill_in "Population", with: @city.Population
    fill_in "Year", with: @city.Year
    click_on "Create City"

    assert_text "City was successfully created"
    click_on "Back"
  end

  test "updating a City" do
    visit cities_url
    click_on "Edit", match: :first

    fill_in "Certainty", with: @city.Certainty
    fill_in "Cityid", with: @city.CityId
    fill_in "Country", with: @city.Country
    fill_in "Latitude", with: @city.Latitude
    fill_in "Longitude", with: @city.Longitude
    fill_in "Name", with: @city.Name
    fill_in "Othername", with: @city.OtherName
    fill_in "Population", with: @city.Population
    fill_in "Year", with: @city.Year
    click_on "Update City"

    assert_text "City was successfully updated"
    click_on "Back"
  end

  test "destroying a City" do
    visit cities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City was successfully destroyed"
  end
end
