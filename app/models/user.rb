class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }

  has_many :tweets, foreign_key: 'author_id'

  has_many :followers, class_name: 'Following', foreign_key: 'followed_id'
  has_many :followeds, class_name: 'Following', foreign_key: 'follower_id'

  mount_uploader :photo, AvatarUploader
  mount_uploader :cover, AvatarUploader
end
