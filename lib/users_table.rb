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

  # This is only here just in case, if not used at the end, delete it
  def list_by_id(id)
    return @db.run("SELECT * FROM users WHERE id=$1;", [id])
  end

  def add(user)
    result = @db.run("INSERT INTO users 
    (username, password, contact, email)
    VALUES ($1, $2, $3, $4) ;",
                     [user.username,
                      user.password,
                      user.contact,
                      user.email])
  end

  def get_user(username:, password:)
    result = @db.run("SELECT * FROM users WHERE username=$1 AND password=$2;", [username, password])
    # The problem here is that if there are no results it gives me index 0 is out of range. how do i refer to it?
    #if result[0]["id"] == nil
    if result.to_a.length < 1
      return false
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
