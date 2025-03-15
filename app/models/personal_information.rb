class PersonalInformation < ApplicationRecord
  belongs_to :user
  has_one_attached :user_image
end
