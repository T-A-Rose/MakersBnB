require "date_handler"

class PropertiesEntity
  # This will need a separate register property erb page
  def initialize(id: nil, property_name:, description:, price:, availability_start:, availability_end:, user_id: nil)
    #id is nil since the DB creates it as a serial field

    @id = id
    @property_name = property_name
    @description = description
    @price = price
    @availability_start = availability_start
    @availability_end = availability_end
    @user_id = user_id
    #availability start and end get declared in another function
  end

  attr_reader :id, :property_name, :description, :price, :availability_start, :availability_end, :user_id
end
