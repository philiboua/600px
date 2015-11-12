class ProfilesController < ApplicationController

  before_action :authenticate_user!
 

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

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :country, :about_me, :user_id)
  end

end