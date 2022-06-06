require_relative "../../app"
require "helpers/database_helpers"

RSpec.describe "Makersbnb features", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("properties")
  end

  it("creates an account, logs in and creates a listing") do
    visit "/Makersbnb"
    fill_in "username", with: "Testing"
    fill_in "password", with: "testing"
    fill_in "contact", with: "00000"
    fill_in "email", with: "testemail@test.com"
    click_button "submit"
    click_link "login"
    fill_in "username", with: "Testing"
    fill_in "password", with: "testing"
    click_button "login"
    expect(page).to have_content "List a new space"
    click_link "new_property"
    fill_in "property_name", with: "Test Space"
    fill_in "description", with: "Test description"
    fill_in "price", with: "49"
    fill_in "availability_start", with: "02/03/2022"
    fill_in "availability_end", with: "12/05/2022"
    click_button "add"
    expect(page).to have_content "List a new space"
  end

  it("fails to log in and redirects to main page") do
    visit "/Makersbnb"
    click_link "login"
    fill_in "username", with: "FaultyTesting"
    fill_in "password", with: "faultytesting"
    click_button "login"
    expect(page).to have_content "Welcome!"
  end
end
