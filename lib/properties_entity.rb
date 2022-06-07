require "date_handler"

class PropertiesEntity
  def initialize(id: nil, property_name:, description:, price:, availability_start:, availability_end:, user_id:)
    @id = id
    @property_name = property_name
    @description = description
    @price = price
    @availability_start = availability_start
    @availability_end = availability_end
    @user_id = user_id
  end

  attr_reader :id, :property_name, :description, :price, :availability_start, :availability_end, :user_id
end
