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
      as_a_user_when_iam_at_the_home_page
      i_want_to_be_able_to_view_my_profile
      and_update_my_profile_information
    end

    def as_a_user_when_iam_at_the_home_page
      visit root_path
    end

    def i_want_to_be_able_to_view_my_profile
      find(".user-name").click
      click_link("view profile")
      expect(page.current_path).to eq profile_path(@profile)
    end

    def and_update_my_profile_information
      click_link("Complete Your Profile")
      fill_in "profile_first_name", with: 'Philippe'
      fill_in "profile_last_name", with: 'Aka'
      fill_in "profile_location", with: 'Toronto'

      within '.profile_country' do
        find("option[value='CA']").click
      end
      
      fill_in "profile_about_me", with: 'Glad to code this website ;)'
      click_button 'Update Profile'
      expect(page.current_path).to eq profile_path(@profile)
    end

end