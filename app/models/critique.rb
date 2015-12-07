class Critique < ActiveRecord::Base

  belongs_to :photo
  belongs_to :profile
  
end
