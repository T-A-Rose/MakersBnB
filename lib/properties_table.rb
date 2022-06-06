class PropertiesTable
  def initialize(db) #db is the db connection provided from database_connection.rb
    @db = db
  end

  def add(property)
    result = @db.run("INSERT INTO properties 
    (property_name, description, price, availability_start, availability_end) 
    VALUES ($1, $2, $3, $4, $5) RETURNING id;",
                     [property.property_name,
                      property.description,
                      property.price,
                      property.availability_start,
                      property.availability_end])
    return result[0]["id"]
  end

  def update_user_id(property:, id:)
    @db.run("UPDATE properties SET user_id =$1")
  end

  def list()
    return @db.run("SELECT * FROM properties ORDER BY id;").map do |row|
             row_to_object(row)
           end
  end

  def row_to_object(row)
    return PropertiesEntity.new(
             id: row["id"],
             property_name: row["property_name"],
             description: row["description"],
             price: row["price"],
             availability_start: row["availability_start"],
             availability_end: row["availability_end"],
             user_id: row["user_id"],
           )
  end
end
