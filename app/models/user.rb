class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_one :personal_information, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  accepts_nested_attributes_for :personal_information

  private

  def password_required?
    new_record? || !password.nil?
  end
end
