require 'rails_helper'


describe Profiles::PhotosController do 

  context "when user is not logged in" do 
    before :each do 
      login_with nil
      @user = create(:user)
      @profile = create(:profile, user_id: @user.id )
      @photo = create(:photo, profile_id: @profile.id)
    end

    it "redirect to login page " do 
      get :show, profile_id: @profile, id: @photo
      expect( response ).to redirect_to(new_user_session_path)
    end
  end

  context "when user is logged in" do 

    before(:each) do 
      @user = create(:user)
      login_with @user
      @profile = create(:profile, user_id: @user.id )
    end

    describe "GET #index" do 
    end



    describe "GET #show" do 
      let(:profile) {create(:profile)}
      let(:photo) {create(:photo)}

      it "finds the given profile and photo and assign to @profile and @photo variables" do 
        get :show, profile_id: profile, id: photo
        expect(assigns(:profile)).to eq (profile)
        expect(assigns(:photo)).to eq (photo)
      end

      it "renders the show view" do
        get :show, profile_id: profile, id: photo
        expect(response).to render_template(:show)
      end


    end

    describe "GET #edit" do 
    end

    describe "PUT #update" do 
    end

    describe "DELETE #destroy" do 
    end


  end 


end