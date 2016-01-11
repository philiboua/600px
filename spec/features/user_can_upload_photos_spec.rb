require 'rails_helper'


RSpec.feature 'Upload photos' do 

  include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do 
    @user = create(:user)
    login_as(@user, :scope => :user)
    @profile = create(:profile, user_id: @user.id)
  end

 
  scenario 'a user can upload photos' do 
    given_the_home_page_is_open
    when_the_user_clicks_on_upload
    then_user_is_redirected_to_new_photo_page
    when_user_fills_in_some_information_about_the_photo
    and_click_on_create_photo
    then_user_is_redirected_to_photo_page
  end


  def given_the_home_page_is_open
    visit root_path
  end

  def when_the_user_clicks_on_upload
    click_link("Upload")
    
  end

  def then_user_is_redirected_to_new_photo_page
    expect(page.current_path).to eq new_photo_path
  end

  def when_user_fills_in_some_information_about_the_photo
    fill_in 'photo_title', with: 'Plage monogaga'
    fill_in 'photo_status', with: 'Public'
    fill_in 'photo_description', with: 'Affaire a suivre le mme'
    attach_file 'photo_photo_upload',"#{Rails.root}/spec/fixtures/profile_new_page.jpg"
  end

  def and_click_on_create_photo
    click_button 'Create Photo'
  end

  def then_user_is_redirected_to_photo_page
    expect(page.current_path).to eq photo_path(Photo.last)
  end

  


end