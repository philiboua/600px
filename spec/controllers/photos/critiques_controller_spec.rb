require 'rails_helper'

describe Photos::CritiquesController do 

  context "User not logged in" do 
    before :each do 
      login_with nil 
      @user = create(:user)
      @photo = create(:photo)
    end

    it " redirect to login page " do 
      get :new, photo_id: @photo
      expect( response ).to redirect_to(new_user_session_path)
    end

  end

  context 'User is logged in ' do 
    before(:each) do 
      @user = create(:user)
      login_with @user
      @profile = create(:profile)
      @photo = create(:photo, profile_id: @profile)
    end

    describe 'GET #new' do 
      let(:photo) {create(:photo)}

      it "finds the given photo and assign to @photo" do
        get :new, photo_id: photo
        expect(assigns(:photo)).to eq photo 
      end 
    end
  end

     








end