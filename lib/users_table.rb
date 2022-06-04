require "users_entity"

class UsersTable
  def initialize(db)
    @db = db
  end

  def list
    return @db.run("SELECT * FROM users ORDER BY id;").map do |row|
             row_to_object(row)
           end
  end

  def list_by_id(id)
    return @db.run("SELECT * FROM users WHERE id=$1;", [id])
  end

  def add(user)
    result = @db.run("INSERT INTO users 
    (username, password, contact, email)
    VALUES ($1, $2, $3, $4) RETURNING id;",
                     [user.username,
                      user.password,
                      user.contact,
                      user.email])
    return result[0]["id"]
  end

  def get_user(username:, password:)
    @db.run("SELECT * FROM users WHERE username=$1 AND password=$2 RETURNING id;", [username, password])
    if result[0]["id"] == nil
      return "Your username or password was entered incorrectly."
    else
      return result[0]["id"]
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
