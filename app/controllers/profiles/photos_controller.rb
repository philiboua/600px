class Profiles::PhotosController < ApplicationController

  before_action :authenticate_user!
  layout 'user'

  def new 
    @profile = Profile.find(params[:profile_id])
    @photo = Photo.new
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @photo = Photo.new(photos_params)
    @photo.profile_id = @profile.id 

    if @photo.save
      redirect_to profile_photo_path(@profile, @photo)
    else
      render :new
    end
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