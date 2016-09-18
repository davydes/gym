class ProfileSerializer < ActiveModel::Serializer
  attributes :name, :first_name, :last_name,
             :gender, :date_of_birth,
             :country, :city
end
