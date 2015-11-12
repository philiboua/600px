require 'rails_helper'

RSpec.feature 'User profile' do 

  include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do
    @user = create(:user)
    login_as(@user, :scope => :user)
    @profile = create(:profile)
  end

    scenario 'User manages his profile' do
      as_a_user_i_want_to_see_my_profile_page
      and_be_able_to_update_my_personal_information
    end

    def as_a_user_i_want_to_see_my_profile_page
      visit profile_path(@user)
    end

    def and_be_able_to_update_my_personal_information
      click_button 'update profile'
      expect(page.current_path).to eq profile_edit_path
      fill_in "First_name", with: 'Philippe'
      fill_in "Last_name", with: 'Aka'
      fill_in "Location", with: 'Toronto'
      fill_in "Country", with: 'Canada'
      fill_in "About me", with: 'Glad to code this website ;)'
      click_button 'save'
      expect(page.current_path).to eq root_path
    end

end