require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:profile)}
  it { should have_many(:profiles).through(:critiques)}
  it { should have_many(:critiques)}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status)}
end
