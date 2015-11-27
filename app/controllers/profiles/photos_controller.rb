class Profiles::PhotosController < ApplicationController

  before_action :authenticate_user!
  layout 'user'

  def index 
  end

  def show 
    @profile = Profile.find(params[:profile_id])
    @photo = Photo.find(params[:id])
  end

  private 

  def photos_params
    params.require(:photo).permit(:title, :description, :photo_upload, :status)
  end


end