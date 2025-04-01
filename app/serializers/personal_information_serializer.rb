class PersonalInformationSerializer < ActiveModel::Serializer
  attributes :id, :username, :city, :country, :user_image_url

  def user_image_url
    if object.user_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.user_image, only_path: true)
    else
      nil
    end
  end
end