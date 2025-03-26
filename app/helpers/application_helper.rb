module ApplicationHelper
  def profile_image_url_for(user)
    if user && user.personal_information&.user_image&.attached?
      url_for(user.personal_information.user_image)
    else
      asset_path("default_profile_image.png")
    end
  end
end
