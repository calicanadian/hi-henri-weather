class User < ApplicationRecord
  require 'faker'
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :locations

  def self.generate_new_user
    # Just create a new user with Faker
    user_email = Faker::Internet.email
    user_password = Faker::Internet.password(min_length: 8, max_length: 20, mix_case: true)
    # make a new user and attempt to save.
    newUser = User.new(email: user_email, password: user_password, password_confirmation: user_password)
    return newUser.save! ? newUser : nil
  end
end
