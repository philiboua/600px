require 'rails_helper'

RSpec.describe Profile, type: :model do

  it { should belong_to(:user)}
  it { should have_many(:photos)}
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:country) }
  

end
