require 'rails_helper'

describe Photos::CritiquesController do 

  context "User not logged in" do 
    let(:user) { create(:user) }
    let(:photo) { create(:photo) }

    before { login_with nil }

    it "redirect to login page " do 
      get :new, photo_id: photo
      expect( response ).to redirect_to(new_user_session_path)
    end

  end

  context 'User is logged in ' do 
    let(:user) { create(:user) }
    let(:profile) { create(:profile) }
    let(:photo) { create(:photo, profile_id: profile ) }

    before { login_with user }
    
    describe 'GET #new' do 

      it "finds the given photo and assign to @photo" do
        get :new, photo_id: photo
        expect(assigns(:photo)).to eq photo 
      end 
    end
  end

     








end