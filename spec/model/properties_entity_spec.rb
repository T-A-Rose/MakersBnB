require "properties_entity"
require "date_handler"

RSpec.describe PropertiesEntity do
  # The tests regarding the time might be changed later
  it("returns the id, property name, description, price and the time bookings are available and end") do
    date_handler = DateHandler.new()
    date_start_1 = date_handler.format(2022, 4, 20)
    date_end_1 = date_handler.format(2022, 7, 15)

    properties_entity = PropertiesEntity.new(
      property_name: "Makers dungeon",
      description: "Sometimes bright, sometimes dark",
      price: "78",
      availability_start: date_start_1,
      availability_end: date_end_1,
    )
    expect(properties_entity.property_name).to eq("Makers dungeon")
    expect(properties_entity.description).to eq("Sometimes bright, sometimes dark")
    expect(properties_entity.price).to eq("78")
    expect(properties_entity.availability_start).to eq(date_start_1)
    expect(properties_entity.availability_end).to eq(date_end_1)
  end
end
