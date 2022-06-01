class UsersEntity
  def initialize(id: nil, username:, password:, contact:, email:)
    @id = id
    @username = username
    @password = password
    @contact = contact
    @email = email
  end

  attr_reader :id, :username, :password, :contact, :email
end
