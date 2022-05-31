class PropertiesEntity
  # This will need a separate register property erb page
  def initialize(id: nil, property_name:, description:, price:, availability_start:, availability_end:)
    #id is nil since the DB creates it as a serial field
    @id = id
    @property_name = property_name
    @description = description
    @price = price
    @availability_start = availability_start
    @availability_end = availability_end
  end

  # I think I will add a formatter here for the time but
  # since I do not know how time is going to be given I will leave this for later
  # maybe use Date.parse?(creates a date from a string)
  # on the page the default value should be given like
  attr_reader :id, :property_name, :description, :price, :availability_start, :availability_end
end
