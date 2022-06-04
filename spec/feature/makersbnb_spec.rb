require_relative "../../app"
require "helpers/database_helpers"

RSpec.describe "Makersbnb features", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("users")
    DatabaseHelpers.clear_table("properties")
  end

  it("creates an account") do
    visit "/Makersbnb"
    click_link "signup"
    fill_in "username", with: "Testing"
    fill_in "password", with: "Testing"
    fill_in "contact", with: "00000"
    fill_in "email", with: "testemail@test.com"
    click_button "submit"
  end
end
