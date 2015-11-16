class ProfilesController < ApplicationController

  respond_to :html, :js

  before_action :authenticate_user!
  layout 'user'
 
  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to @profile
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update 
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      redirect_to @profile
    else
      render :edit 
    end
  end



  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :country, :about_me, :user_id)
  end

end