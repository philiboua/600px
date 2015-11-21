require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:profile)}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status)}
end
