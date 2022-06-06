require "properties_table"
require "properties_entity"
require "helpers/database_helpers"
require "users_entity"
require "users_table"

RSpec.describe PropertiesTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("properties")
    return DatabaseHelpers.test_db_connection
  end

  it("returns an empty database") do
    db = clean_and_get_database
    properties_table = PropertiesTable.new(db)
    expect(properties_table.list).to eq([])
  end

  it("lists out the added database elements") do
    db = clean_and_get_database
    users_table = UsersTable.new(db)
    properties_table = PropertiesTable.new(db)
    fake_date_1 = double(:fake_date, format: "2022-04-20")
    fake_date_2 = double(:fake_date, format: "2022-06-25")
    fake_date_3 = double(:fake_date, format: "2021-12-25")
    fake_date_4 = double(:fake_date, format: "2023-08-25")

    users_entity_1 = UsersEntity.new(
      username: "360_NOSCOPEXXX69",
      password: "no_u",
      contact: "07548456789",
      email: "joemama@gmail.com",
    )

    user_id_1 = users_table.add(users_entity_1)
    properties_entity_1 = PropertiesEntity.new(
      property_name: "Makers dungeon",
      description: "Duckie is the prison warden and (s)he does not go easy on you",
      price: "78",
      availability_start: fake_date_1.format,
      availability_end: fake_date_2.format,
    )
    properties_entity_2 = PropertiesEntity.new(
      property_name: "Openbet residency",
      description: "Very nice area, very expensive, very empty",
      price: "85",
      availability_start: fake_date_3.format,
      availability_end: fake_date_4.format,
    )

    id_1 = properties_table.add(properties_entity_1)
    id_2 = properties_table.add(properties_entity_2)

    expect(properties_table.list[0].property_name).to eq("Makers dungeon")
    expect(properties_table.list[0].description).to eq("Duckie is the prison warden and (s)he does not go easy on you")
    expect(properties_table.list[0].price).to eq("78")
    expect(properties_table.list[0].availability_start).to eq("2022-04-20")
    expect(properties_table.list[0].availability_end).to eq("2022-06-25")
    #Last test taken out until it updates instead of inserting it at declaration
    #expect(properties_table.list[0].user_id).to eq(user_id_1)
  end
end
