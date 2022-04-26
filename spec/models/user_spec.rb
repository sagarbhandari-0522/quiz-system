require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'should presence email' do
      user = User.new(email: 'sagarvandari1@gmail.com', password: 'password')
      expect(user).to be_valid
      user = User.new(email: nil, password: 'password')
      expect(user).to_not be_valid
    end
    it 'should presence password' do
      user = User.new(email: 'sagarvandari1@gmail.com', password: 'password')
      expect(user).to be_valid
      user = User.new(email: 'sagarvandari', password: nil)
      user.validate
      expect(user.errors[:password]).to include("can't be blank")
    end
    it 'should match the password' do
      user = User.new(email: 'sagarvandari1@gmail.com', password: 'password')
      expect(user).to be_valid
      user = User.new(email: 'sagarvandari1@gmail.com', password: 'password', password_confirmation: 'a')
      user.validate
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      # expect(user).to_not be_valid
    end
  end
end
