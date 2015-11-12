require 'rails_helper'

describe ProfilesController do

  context "User is not logged in " do 

    before :each do
      login_with nil
    end 

    it " redirects to login page" do 
      #Example with user requesting to view new_profile_page
      get :new
      expect( response ).to redirect_to( new_user_session_path )
    end

  end

  context "User is logged in" do

    before(:each) do
      login_with create( :user )
    end


    describe "GET #new" do

      it "assigns a new profile object to the @profile variable" do
        get :new
        expect(assigns(:profile)).to be_instance_of(Profile)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

    end

    describe "POST #create" do 

      context "with valid attributes" do 

        it "saves the new profile object" do
          expect {
              post :create, profile: attributes_for(:profile, user_id: '1')
            }.to change(Profile, :count).by(1)
        end

        it "redirect to show page" do 
          post :create, profile: attributes_for(:profile, user_id: '1')
          expect(response).to redirect_to Profile.last
        end

      end

      context "with invalid attributes" do 

        it "does not save the new profile to database" do
          expect {
              post :create, profile: attributes_for(:profile,first_name: nil, user_id: '1')
            }.to_not change(Profile, :count)
        end

        it "renders the the new template" do 
          post :create, profile: attributes_for(:profile,first_name: nil, user_id: '1')
          expect(response).to render_template :new
        end

        
      
      end

    describe "GET #show" do 
      it "assigns the requrested Profile to @profile" do 
        profile = create(:profile)
        get :show, id: profile
        expect(assigns(:profile)).to eq(profile)
      end

      it "renders the show view" do
        profile = create(:profile)
        get :show, id: profile 
        expect(response).to render_template(:show)
      end
    end

    end

  end


end


    




  

  

  