class Photo < ActiveRecord::Base

  belongs_to :profile
  has_many :critiques
  has_many :profiles, through: :critiques
  validates_presence_of :title, :status

  mount_uploader :photo_upload, PhotoUploadUploader

  def been_reviewed?(profile)
    critique = critiques.where(profile_id: profile).first
    critique.nil?
  end

  
end
