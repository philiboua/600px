require 'rails_helper'

RSpec.feature 'User can review published photos' do 

include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do 
    @user = create(:user)
    login_as(@user, :scope => :user)
    @profile = create(:profile, user_id: @user.id )
    @photo = create(:photo, profile_id: @profile.id)
  end

  context 'user left a review' do 

    before(:each) do 
      @critique = create(:critique, photo_id: @photo.id, profile_id: @profile.id)
    end
    
    scenario " user can see his review" do 
      given_the_home_page_is_open
      when_the_user_clicks_on_a_photo
      then_the_user_is_redirected_to_the_photo_page
      then_the_page_should_reload_with_his_review
    end

  end

  context 'user never review the photo ' do 

    before(:each) do 
      @critique = create(:critique)
    end

    scenario 'User write a review' do 
      given_the_home_page_is_open
      when_the_user_clicks_on_a_photo
      then_the_user_is_redirected_to_the_photo_page
      when_the_user_fill_in_the_review_form
      and_click_on_submit_review
      then_the_page_should_reload_with_his_review
    end

  end

  
  #methods common to both contexts
  def given_the_home_page_is_open
    visit photos_path
  end

  def when_the_user_clicks_on_a_photo
    first('.photo-wrapper > a').click
  end

  def then_the_user_is_redirected_to_the_photo_page
    expect(page.current_path).to eq photo_path(@photo)
  end

  def when_the_user_fill_in_the_review_form

    within(".new-critique") do 
      fill_in 'Composition', with: "#{@critique.composition}"
      fill_in 'Lighting', with: "#{@critique.lighting}"
      fill_in 'First impressions', with: "#{@critique.first_impressions}"
    end 

  end

  def and_click_on_submit_review
    within(".new-critique") do 
      click_on 'submit your review'
    end
  end

  def then_the_page_should_reload_with_his_review
    expect(page).to have_content "#{@critique.composition}"
  end


end