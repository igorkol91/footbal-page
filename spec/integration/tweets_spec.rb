require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'associations', type: :model do
    it { should belong_to(:author) }

    it 'Expect true if tweet body has text' do
      tweet = Tweet.create(text: 'My first test Tweet')

      expect(tweet).to be_truthy
    end

    it 'Expect false if tweet body is empty' do
      tweet = Tweet.create

      expect(tweet.id).to be_falsey
    end
  end
end
