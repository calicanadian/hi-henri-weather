require 'rails_helper'

describe User do
  it 'should generate new user' do
    newUser = User.generate_new_user
    expect(newUser).to be_valid
    expect(newUser.id).not_to be_nil
    expect(newUser.email).not_to be_nil
    expect(newUser.password_digest).not_to be_nil
  end
end
