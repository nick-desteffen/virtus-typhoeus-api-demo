class Address
  include Virtus.model

  attribute :id,       Integer
  attribute :street1,  String
  attribute :street2,  String
  attribute :city,     String
  attribute :state,    String
  attribute :zip_code, String

  def to_s
    "#{street1}\n#{street2}\n#{city}, #{state} #{zip_code}"
  end

end
