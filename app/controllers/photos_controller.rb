class PhotosController < ApplicationController 
  
  before_action :authenticate_user!
  before_action :photo_been_reviewed_by_user?, only: [:show]

  layout 'user'

  def index
    @photos = Photo.all
  end

  def new 
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photos_params)
    @photo.profile_id = current_user.profile

    if @photo.save
      redirect_to @photo
    else
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end


  private 

  def photo_been_reviewed_by_user?
    @photo = Photo.find(params[:id])
    @profile = current_user.profile
    @been_reviewed = @photo.been_reviewed?(@profile.id)
  end

  def photos_params
    params.require(:photo).permit(:title, :photo_upload, :description, :status)
  end
  
end