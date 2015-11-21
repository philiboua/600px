require 'rails_helper'


describe Profiles::PhotosController do 

  context "when user is not logged in" do 
    before :each do 
      login_with nil
      @user = create(:user)
      @profile = create(:profile, user_id: @user.id )
    end

    it "redirect to login page " do 
      get :new, profile_id: @profile
      expect( response ).to redirect_to(new_user_session_path)
    end
  end

  context "when user is logged in" do 

    before(:each) do 
      @user = create(:user)
      login_with create( :user )
      @profile = create(:profile, user_id: @user.id )
    end

    describe "GET #index" do 
    end

    describe "GET #new" do 
      let(:profile) {create(:profile)}

      it "finds the profile with the given id and assigns to @profile variable" do 
        get :new, profile_id: profile
        expect(assigns(:profile)).to eq (profile)
      end

      it "assigns a new photo object to the @photo variabale" do 
        get :new, profile_id: profile
        expect(assigns(:photo)).to be_instance_of(Photo)
      end

      it "renders the new template" do 
        get :new, profile_id: profile
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do 
      let(:profile) {create(:profile)}

      context "with valid attributes" do 

        it "saves the new photo object" do
        expect{ post :create, profile_id: profile, photo:  attributes_for(:photo, profile_id: profile.id)
        }.to change(Photo, :count).by(1)
        end

        it "redirect to show page " do 
          post :create, profile_id: profile, photo: attributes_for(:photo, profile_id: profile.id)
          expect(response).to redirect_to profile_photo_path(profile.id,Photo.last)
        end
      end

      context "with invalid attributes" do 
        it "does not save the new photo to database" do
          expect{ 
            post :create, profile_id: profile, photo: attributes_for(:photo, title: nil, profile_id: profile.id)
          }.to_not change(Photo,:count)
        end

        it "renders the new template" do 
          post :create, profile_id: profile, photo: attributes_for(:photo, title: nil, profile_id: profile.id)
          expect(response).to render_template(:new)
        end
      end
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