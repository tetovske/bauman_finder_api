require 'rails_helper'

RSpec.describe User, type: :model do
  context 'if user is trying to add existing variables' do
    let(:user_data) do
      {
        :email => 'test@email.com',
        :password => '123456',
        :password_confirmation => '123456',
        :token => '1'
      }
    end 

    it 'should return false' do
      fake_user = User.new(user_data)
      fake_user.token = '11'
      fake_user.save if exs = User.find_by(:email => 'test@email.com').nil?
      another_fake = User.new(user_data)
      expect(another_fake.valid?).to be_falsy
      fake_user.destroy if exs.nil?
    end

    it 'should also return false as tokens should not be repeated!' do
      fake_user = User.new(user_data)
      fake_user.email = 'another@email.com'
      fake_user.save if exs = User.find_by(:token => '1').nil?
      another_fake = User.new(user_data)
      expect(another_fake.valid?).to be_falsy
      User.find_by(:email => 'test@email.com').destroy if exs.nil?
    end
  end
end
