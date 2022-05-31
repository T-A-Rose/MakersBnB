require "properties_table"
require "properties_entity"
require "helpers/database_helpers"

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
    properties_table = PropertiesTable.new(db)
    properties_entity_1 = PropertiesEntity.new(
      property_name: "Makers dungeon",
      description: "Duckie is the prison warden and (s)he does not go easy on you",
      price: "78",
      availability_start: 20 / 04 / 2022,
      availability_end: 25 / 06 / 2022,
    )
    properties_entity_2 = PropertiesEntity.new(
      property_name: "Openbet residency",
      description: "Very nice area, very expensive, very empty",
      price: "85",
      availability_start: 25 / 06 / 2022,
      availability_end: 14 / 10 / 2022,
    )

    id_1 = properties_table.add(properties_entity_1)
    id_2 = properties_table.add(properties_entity_2)
    expect(properties_table.list[0]).to eq([properties_entity_1])
  end
end
