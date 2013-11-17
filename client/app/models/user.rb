class User
  include Api::Base

  attribute :id,         Integer
  attribute :first_name, String
  attribute :last_name,  String
  attribute :email,      String
  attribute :auth_token, String
  attribute :addresses,  Array[Address]

  def name
    "#{first_name} #{last_name}"
  end

end
