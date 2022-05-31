require "properties_entity"

RSpec.describe PropertiesEntity do
  # The tests regarding the time might be changed later
  it("returns the id, property name, description, price and the time bookings are available and end") do
    properties_entity = PropertiesEntity.new(
      property_name: "Makers dungeon",
      description: "Sometimes bright, sometimes dark",
      price: "78",
      availability_start: 2022 / 04 / 20,
      availability_end: 2022 / 06 / 25,
    )
    expect(properties_entity.property_name).to eq("Makers dungeon")
    expect(properties_entity.description).to eq("Sometimes bright, sometimes dark")
    expect(properties_entity.price).to eq("78")
    expect(properties_entity.availability_start).to eq(2022 / 04 / 20)
    expect(properties_entity.availability_end).to eq(2022 / 06 / 25)
  end
end
