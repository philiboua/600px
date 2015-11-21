require 'rails_helper'

RSpec.feature 'Upload photos' do 

  include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do 
    @user = create(:user)
    login_as(@user, :scope => :user)
    @profile = create(:profile, user_id: @user.id)
  end

 
  scenario 'a user can upload photos to his profile' do 
    as_a_user_when_iam_at_the_home_page
    and_i_click_on_upload
    i_should_be_able_to_provide_general_info_about_my_photo
    and_upload_the_file
  end

  def as_a_user_when_iam_at_the_home_page
    visit root_path
  end

  def and_i_click_on_upload
    click_link("Upload")
    expect(page.current_path).to eq new_profile_photo_path(@profile)
  end

  def i_should_be_able_to_provide_general_info_about_my_photo
    fill_in 'photo_title', with: 'Plage monogaga'
    fill_in 'photo_status', with: 'Public'
    fill_in 'photo_description', with: 'Affaire a suivre le mme'
    attach_file 'photo_photo_upload',"#{Rails.root}/spec/fixtures/profile_new_page.jpg"
  end

  def and_upload_the_file
    click_button 'Create Photo'
    expect(page.current_path).to eq profile_photo_path(@profile.id, Photo.last)
  end

  


end