class Photos::CritiquesController < ApplicationController 

  before_action :authenticate_user!

  def new 
    @photo = Photo.find(params[:photo_id])
    @critique = Critique.new
  end

  def create 
    @photo = Photo.find(params[:photo_id])
    @profile = current_user.profile
    @critique = Critique.new(critique_params)
    @critique.photo_id = @photo.id
    @critique.profile_id = @profile.id
    if @critique.save
      redirect_to photo_path(@photo)
    else
      redirect_to root_path
    end
  end

  def view_critiques
    @photo = Photo.find(params[:photo_id])
    @critique = Critique.find(params[:id])
    render :partial=> 'view_critique'  
  end
  helper_method :view_critique

  
  private

  def critique_params
    params.require(:critique).permit(:first_impressions, :composition, :lighting)
  end


end