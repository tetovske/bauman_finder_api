require 'rails_helper'

RSpec.describe User, type: :model do
  context 'if user is trying to add existing variables' do
    it 'should return false because email is uniq' do
      fake_email = Faker::Internet.email
      create(:default_user, email: fake_email)
      expect(build(:default_user, email: fake_email).valid?).to be_falsy
    end

    it 'should also return false as tokens should not be repeated!' do
      fake_token = Faker::Internet.password
      create(:default_user).tap do |u| 
        u.bf_api_token = fake_token
        u.save! 
      end
      expect(build(:default_user).tap { |u| u.bf_api_token = fake_token }.valid?).to be_falsy
    end
  end
end
