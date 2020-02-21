require 'rails_helper'

RSpec.describe User, type: :model do
  context 'if user is trying to add existing variables' do
    let(:user_data) do
      {
        :email => Faker::Internet.email,
        :password => '123456',
        :password_confirmation => '123456'
      }
    end 

    it 'should return false because email is uniq' do
      fake_email = Faker::Internet.email
      create(:user, email: fake_email)
      expect(build(:user, email: fake_email).valid?).to be_falsy
      # fake_user = User.new(user_data).tap { |u| u.skip_confirmation! }
      # fake_user.save if exs = User.find_by(email: fake_user.email).nil?
      # another_fake = User.new(user_data).tap { |u| u.skip_confirmation! } 
      # expect(another_fake.valid?).to be_falsy
      # fake_user.destroy if exs.nil?
    end

    it 'should also return false as tokens should not be repeated!' do
      # fake_user = User.new(user_data).tap { |u| u.skip_confirmation! }
      # fake_user.email = 'another@email.com'
      # fake_user.save if exs = User.find_by(:bf_api_token => '******').nil?
      # another_fake = User.new(user_data)
      # expect(another_fake.valid?).to be_falsy
      # User.find_by(:email => 'test@email.com').destroy if exs.nil?
    end
  end
end
