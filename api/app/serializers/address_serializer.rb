class AddressSerializer < ActiveModel::Serializer

  attributes :id, :user_id, :street1, :street2, :city, :state, :zip_code

end
