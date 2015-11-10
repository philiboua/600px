require 'rails_helper'

RSpec.feature 'signs in flow' do 

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

    scenario 'User signs in with correct credentials' do
      as_user_when_i_visit_new_user_session_page
      and_fill_in_my_email_and_password
      and_click_log_in
      i_should_be_redirected_to_root_page
    end

    scenario 'User signs in with incorrect credentials' do
      as_user_when_i_visit_new_user_session_page
      and_fill_in_an_incorrect_email_and_password
      and_click_log_in
      i_should_be_redirected_to_signin_page
    end

    def as_user_when_i_visit_new_user_session_page
      visit new_user_session_path
    end

    def and_fill_in_my_email_and_password
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
    end

    def and_fill_in_an_incorrect_email_and_password
      fill_in "Email", with: 'philippe'
      fill_in "Password", with: @user.password
    end

    def and_click_log_in
      click_button 'Log in'
    end

    def i_should_be_redirected_to_root_page
      expect(page.current_path).to eq root_path
    end

    def i_should_be_redirected_to_signin_page
      expect(page.current_path).to eq "/users/sign_in"
    end

  
end