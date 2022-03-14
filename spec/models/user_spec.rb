require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'user will save with first name' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true
    end

    it 'user will not save with missing first name' do
      @user =
        User.new(
          first_name: nil,
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be false
      expect(@user.errors.messages[:first_name]).to include "can't be blank"
    end

    it 'user will save with last name' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true
    end

    it 'user will not save with missing last name' do
      @user =
        User.new(
          first_name: 'John',
          last_name: nil,
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be false
      expect(@user.errors.messages[:last_name]).to include "can't be blank"
    end

    it 'user will save with email' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true
    end

    it 'user will not save with missing email' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: nil,
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be false
      expect(@user.errors.messages[:email]).to include "can't be blank"
    end

    it 'user will save when password and confirmation are matching' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true
    end

    it 'user will not save when password and confirmation are not matching' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password1',
        )
      @user.save
      expect(@user.valid?).to be false
      expect(
        @user.errors.messages[:password_confirmation],
      ).to include "doesn't match Password"
    end

    it 'user will not save when password length under 6 characters' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'pass',
          password_confirmation: 'pass',
        )
      @user.save
      expect(@user.valid?).to be false
      expect(
        @user.errors.messages[:password_confirmation],
      ).to include 'is too short (minimum is 6 characters)'
    end

    it 'user will not save when email is not unique' do
      @user =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true

      @user2 =
        User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'johnsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user2.save
      expect(@user2.valid?).to be false
      expect(@user2.errors.messages[:email]).to include 'has already been taken'
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should login user if credentials are valid' do
      @user =
        User.new(
          first_name: 'Bob',
          last_name: 'Smith',
          email: 'bobsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true

      userAuth = User.authenticate_with_credentials(@user.email, @user.password)
      expect(userAuth.id).to be @user.id
    end

    it 'should not login user if credentials are invalid' do
      @user =
        User.new(
          first_name: 'Bob',
          last_name: 'Smith',
          email: 'bobsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true

      userAuth =
        User.authenticate_with_credentials(@user.email, 'wrongpassword')
      expect(userAuth).to be nil
    end

    it 'should login user if credentials are valid with whitespace and wrongcase email' do
      @user =
        User.new(
          first_name: 'Rob',
          last_name: 'Smith',
          email: 'robsmith@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )
      @user.save
      expect(@user.valid?).to be true

      userAuth =
        User.authenticate_with_credentials(
          '  robSMITH@gmail.com ',
          @user.password,
        )
      expect(userAuth.id).to be @user.id
    end
  end
end
