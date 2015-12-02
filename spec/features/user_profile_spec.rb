require 'rails_helper'

RSpec.feature 'User profile' do 

  include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do
    @user = create(:user)
    login_as(@user, :scope => :user)
    @profile = create(:profile, user_id: @user.id )
  end


    scenario 'User can update his profile' do
      given_the_home_page_is_open
      when_the_user_view_his_profile
      and_update_his_profile_information
      then_user_should_see_his_profile_updated
    end

    def given_the_home_page_is_open
      visit root_path
    end

    def when_the_user_view_his_profile
      find(".user-name").click
      click_link("view profile")
      expect(page.current_path).to eq profile_path(@profile)
    end

    def and_update_his_profile_information
      click_link("Complete Your Profile")
      fill_in "profile_first_name", with: 'Philippe'
      fill_in "profile_last_name", with: 'Aka'
      fill_in "profile_location", with: 'Toronto'
      within '.profile_country' do
        find("option[value='CA']").click
      end
      fill_in "profile_about_me", with: 'Glad to code this website ;)'
      click_button 'Update Profile'
    end

    def then_user_should_see_his_profile_updated
      expect(page.current_path).to eq profile_path(@profile.id)
    end

end