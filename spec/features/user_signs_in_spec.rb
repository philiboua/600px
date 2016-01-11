require 'rails_helper'

RSpec.feature 'signs in flow' do 

  before do
    @user = create(:user)
    @profile = create(:profile, user_id: @user.id )
  end

    scenario 'User signs in with correct credentials' do
      given_the_login_page_is_open
      when_user_fills_in_login_form
      and_click_on_log_in
      then_user_is_redirected_to_home_page
    end

    scenario 'User signs in with incorrect credentials' do
      given_the_login_page_is_open
      when_user_fills_in_incorectly_login_form
      and_click_on_log_in
      then_user_is_redirected_to_signin_page
    end

    def given_the_login_page_is_open
      visit new_user_session_path
    end

    def when_user_fills_in_login_form
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
    end

    def when_user_fills_in_incorectly_login_form
      fill_in "Email", with: 'philippe'
      fill_in "Password", with: @user.password
    end

    def and_click_on_log_in
      click_button 'Log in'
    end

    def then_user_is_redirected_to_home_page
      expect(page.current_path).to eq root_path
    end

    def then_user_is_redirected_to_signin_page
      expect(page.current_path).to eq "/users/sign_in"
    end

  
end