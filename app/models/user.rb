class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_one :personal_information, dependent: :destroy
  validates :email, presence: true, uniqueness: true

  accepts_nested_attributes_for :personal_information

  after_create :create_default_personal_information

  private

  def create_default_personal_information
    create_personal_information(username: "User_#{id}")
  end

end
