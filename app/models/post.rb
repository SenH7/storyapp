class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: { message: "cannot be blank" }
  validates :content, presence: { message: "cannot be blank" }
end
