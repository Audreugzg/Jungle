require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should create a valid user' do
      user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: "   test@test.com",
        password: "testing",
        password_confirmation: "testing"
      )
      expect(user).to be_valid
    end

    it 'should have a matching password and password confirmation' do
      user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: "test@test.com",
        password: "testing",
        password_confirmation: "incorrect"
      )
      expect(user.password).to_not be_equal(user.password_confirmation)
    end

    it 'should have a password and password confirmation' do
      user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: "test@test.com",
        password: "testing",
        password_confirmation: nil
      )
      expect(user).to_not be_valid
    end

    it 'should have a first name' do
      user = User.create(
        first_name: nil,
        last_name: "Quirk",
        email: "test@test.com",
        password: "testing",
        password_confirmation: "testing"
      )
      expect(user).to_not be_valid
    end

    it 'should have a last name' do
      user = User.create(
        first_name: "Evan",
        last_name: nil,
        email: "test@test.com",
        password: "testing",
        password_confirmation: "testing"
      )
      expect(user).to_not be_valid
    end

    it 'should not save without an unique email' do
      @user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: "test@test.com",
        password_digest: "testing"
      )
      @user2 = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: "test@test.COM",
        password_digest: "testing"
      )
      expect(@user2).to_not be_valid
    end

    it 'should have an email to be a valid user' do
      user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: nil,
        password: "testing",
        password_confirmation: "testing"
      )
      expect(user).to_not be_valid
    end

    it 'should have a password with a minimum length of 5' do
      user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: nil,
        password: "test",
        password_confirmation: "test"
      )
      expect(user).to_not be_valid
    end
  end

  describe '.authentical_with_credentials' do

    it 'should authenticate if email and password are valid' do
      user = User.create(
        first_name: "Evan",
        last_name: "Quirk",
        email: "test@test.com",
        password: "testing",
        password_confirmation: "testing"
      )
      authenticate = User.authenticate_with_credentials(user.email, user.password)
      expect(authenticate).to eq(user)
    end
  end
end