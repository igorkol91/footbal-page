require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text) }
  end
end
