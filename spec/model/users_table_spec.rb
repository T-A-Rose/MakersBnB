require "users_table"
require "users_entity"

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
end
