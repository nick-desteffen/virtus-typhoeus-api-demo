class User < ActiveRecord::Base

  has_many :addresses, dependent: :destroy

  has_secure_password

  before_create :generate_auth_token

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email

private

  def generate_auth_token
    self.auth_token = SecureRandom.hex(4) + Time.now.to_i.to_s + SecureRandom.hex(4)
  end

end
