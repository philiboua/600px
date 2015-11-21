class Photo < ActiveRecord::Base

  belongs_to :profile
  validates_presence_of :title, :status

  mount_uploader :photo_upload, PhotoUploadUploader
  #validates_presence_of :photo_upload, message: "Please select a photo to upload"

  
end
