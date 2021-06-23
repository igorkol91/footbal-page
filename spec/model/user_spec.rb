require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:tweets) }
    it { should have_many(:followers) }
    it { should have_many(:followeds) }

    it 'returns true if user was created correctly' do
      user = User.create(email: 'user1@gmail.com', username: 'user1')
      expect(user).to be_truthy
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username) }
  end
end
