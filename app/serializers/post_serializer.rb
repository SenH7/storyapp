class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at
  belongs_to :user
  has_many :comments
end