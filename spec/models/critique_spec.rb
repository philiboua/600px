require 'rails_helper'

RSpec.describe Critique, type: :model do

  it { should belong_to(:photo) }
  it { should belong_to(:profile) }
  
end
