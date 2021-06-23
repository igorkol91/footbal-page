class Tweet < ApplicationRecord
  validates :text, presence: true, length: { maximum: 200,
                                             too_long: '200 characters in post is the maximum allowed.' }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
end
