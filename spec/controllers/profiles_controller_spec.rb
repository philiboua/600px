require 'rails_helper'

describe ProfilesController do

  context "User is not logged in " do 

    before :each do
      login_with nil
      create(:user)
    end 


    it "redirects to login page" do 
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
        it "renders the new template" do 
          post :create, profile: attributes_for(:profile,first_name: nil, user_id: '1')
          expect(response).to render_template :new
        end    
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

    describe "GET #edit" do 
      let(:profile) {create(:profile)}

      it "finds the profile with the given id and assigns to @profile variable" do 
        get :edit, id: profile
        expect(assigns(:profile)).to eq(profile)
      end

      it "renders the edit template" do 
        get :edit, id: profile 
        expect(response).to render_template(:edit)
      end
    end

    describe "PUT #update" do 
      context "a successful update" do 
        let(:profile) {create(:profile)}

        it "updates the modified profile object" do 
          put :update, profile: attributes_for(:profile, first_name: 'Philippe', last_name: 'aka'), id: profile.id
          expect(Profile.first.first_name).to eq('Philippe')
        end 

        it "redirect to the show page " do 
          put :update, profile: attributes_for(:profile, first_name: 'Philippe', last_name: 'aka'), id: profile.id
          expect(response).to redirect_to profile_path(Profile.last)
        end

      end

      context "an unsuccessful update" do 
        let(:profile) {create(:profile, first_name: 'Paul')}
        it "does not update the modified profile object" do 
          put :update, profile: attributes_for(:profile, first_name: 'Philippe', last_name: nil), id: profile.id
          expect(Profile.first.first_name).to eq('Paul')
        end 

        it "redirect to the edit page " do 
          put :update, profile: attributes_for(:profile, first_name: 'Philippe', last_name: nil), id: profile.id
          expect(response).to render_template :edit
        end
      end
    end

    
  end
end






    




  

  

  
