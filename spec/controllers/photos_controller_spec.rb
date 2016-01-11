require 'rails_helper'

describe PhotosController do 

  context "User not logged in " do 
    before :each do 
      login_with nil 
      @user = create(:user)
      @profile = create(:profile, user_id: @user.id)
    end

    describe "GET #index" do
      it "redirects to login page" do 
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end 
    end
    
  end

  context "User logged in" do 
    before :each do 
      @user = create(:user)
      login_with @user
    end 


    describe "GET #new" do 

      let(:profile) {create(:profile)}

      it "assigns a new photo object to the @photo variabale" do 
        get :new
        expect(assigns(:photo)).to be_instance_of(Photo)
      end

      it "renders the new template" do 
        get :new
        expect(response).to render_template(:new)
      end
    end


    describe "POST #create" do 

      let(:profile) {create(:profile)}

      context "with valid attributes" do 

        it "saves the new photo object" do
        expect{ post :create, photo:  attributes_for(:photo, profile_id: profile)
        }.to change(Photo, :count).by(1)
        end

        it "redirect to show page " do 
          post :create,  photo: attributes_for(:photo, profile_id: profile.id)
          expect(response).to redirect_to photo_path(Photo.last)
        end
      end
    end

    describe "GET #show" do 
      let!(:photo) {create(:photo)}
      
      it "finds the given photo and assign to @photo variable" do 
        controller.stub(:photo_been_reviewed_by_user?)
        get :show, id: photo
        expect(assigns(:photo)).to eq(photo)
      end

      it "renders the show view" do
        controller.stub(:photo_been_reviewed_by_user?)
        get :show, id: photo
        expect(response).to render_template(:show)
      end
    end


    describe "GET #index" do 
      it "assigns the photos object to the @photos variable" do 
        photo1 = create(:photo)
        photo2 = create(:photo)

        get :index
        expect(assigns(:photos)).to match_array([photo1, photo2])
      end

      it "renders the index page" do 
        get :index
        expect(response).to render_template(:index)
      end
    end

  end

end