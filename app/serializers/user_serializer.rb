class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username

  def username
    object.personal_information&.username || object.email
  end
end