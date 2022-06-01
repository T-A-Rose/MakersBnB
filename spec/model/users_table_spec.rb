require "users_table"
require "users_entity"
require "helpers/database_helpers"

RSpec.describe UsersTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("users")
    return DatabaseHelpers.test_db_connection
  end

  it("returns an empty database") do
    db = clean_and_get_database
    users_table = UsersTable.new(db)
    expect(users_table.list).to eq([])
  end

  it("adds a user to the table") do
    db = clean_and_get_database
    users_table = UsersTable.new(db)
    users_entity_1 = UsersEntity.new(
      username: "360_NOSCOPEXXX69",
      password: "no_u",
      contact: "07548456789",
      email: "joemama@gmail.com",
    )
    id_1 = users_table.add(users_entity_1)
    expect(users_table.list[0].username).to eq("360_NOSCOPEXXX69")
    expect(users_table.list[0].password).to eq("no_u")
    expect(users_table.list[0].contact).to eq("07548456789")
    expect(users_table.list[0].email).to eq("joemama@gmail.com")
  end
end
