require 'rails_helper'

describe User do 
  it { should have_one(:profile)}
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:encrypted_password) }
  
end
