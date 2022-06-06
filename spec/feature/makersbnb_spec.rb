require_relative "../../app"
require "helpers/database_helpers"

RSpec.describe "Makersbnb features", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("properties")
  end

  it("creates an account and logs in") do
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
  end

  it("fails to log in and redirects to main page") do
    visit "/Makersbnb"
    click_link "login"
    fill_in "username", with: "FaultyTesting"
    fill_in "password", with: "faultytesting"
    click_button "login"
    expect(page).to have_content "Welcome!"
  end

  xit("posts a listing") do
  end
end
