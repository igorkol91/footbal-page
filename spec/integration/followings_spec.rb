# rubocop:disable Lint/UselessAssignment
require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'associations', type: :model do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed).class_name('User') }

    it 'Expect true if user1 is following user2' do
      user1 = User.create(email: 'user1@user', username: 'user1')
      user2 = User.create(email: 'user2@user', username: 'user2')
      following = Following.create(follower_id: user1.id, followed_id: user2.id)

      expect(user2.followers.first.follower_id).to eq(user1.id)
    end

    it 'Expect false if user2 is not following user1' do
      user1 = User.create(email: 'user1@user', username: 'user1')
      user2 = User.create(email: 'user2@user', username: 'user2')
      following = Following.create(follower_id: user1.id, followed_id: user2.id)

      expect(following.follower_id == user2.id).to eq(false)
    end
  end
end
# rubocop:enable Lint/UselessAssignment
