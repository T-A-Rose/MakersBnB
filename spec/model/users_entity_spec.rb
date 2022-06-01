require "users_entity"

RSpec.describe UsersEntity do
  it("returns username, password, contact, email") do
    users_entity_1 = UsersEntity.new(
      username: "360_NOSCOPEXXX69",
      password: "no_u",
      contact: "07548456789",
      email: "joemama@gmail.com",
    )
    expect(users_entity_1.id).to eq(nil)
    expect(users_entity_1.username).to eq("360_NOSCOPEXXX69")
    expect(users_entity_1.password).to eq("no_u")
    expect(users_entity_1.contact).to eq("07548456789")
    expect(users_entity_1.email).to eq("joemama@gmail.com")
  end
end
