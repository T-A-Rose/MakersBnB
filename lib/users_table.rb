require "users_entity"

class UsersTable
  def initialize(db)
    @db = db
  end

  def list()
    return @db.run("SELECT * FROM users ORDER BY id;").map do |row|
             row_to_object(row)
           end
  end

  def row_to_object(row)
    return UsersEntity.new(
             id: row["id"],
             username: row["username"],
             password: row["password"],
             contact: row["contact"],
             email: row["email"],
           )
  end
end
