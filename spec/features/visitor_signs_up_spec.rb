require 'rails_helper'

RSpec.feature 'Visitor signs up' do 

  scenario 'Visitor signs up with valid emails and password' do
    given_the_registration_page_is_open
    when_user_fills_in_signup_form
    and_cliks_on_signup
    then_user_is_redirected_to_new_profile_page
  end

  scenario 'Visitor signs up with invalid email or password' do
    given_the_registration_page_is_open
    when_user_fills_in_incorectly_signup_form
    and_cliks_on_signup
    then_user_is_redirected_to_users_page
  end

  def given_the_registration_page_is_open
    visit new_user_registration_path
  end

  def when_user_fills_in_signup_form
    fill_in "user_email", with: 'philippe@600px.fr'
    fill_in "user_password", with: 'solodugrandb'
    fill_in "user_password_confirmation", with: 'solodugrandb'
  end

  def when_user_fills_in_incorectly_signup_form
    fill_in "user_email", with: 'philippe'
    fill_in "user_password", with: 'solodugrandb'
    fill_in "user_password_confirmation", with: 'solodugrandb'
  end

  def and_cliks_on_signup
    click_button 'Sign up'
  end

  def then_user_is_redirected_to_new_profile_page
    @user = create(:user)
    login_as(@user, :scope => :user)
    expect(page.current_path).to eq new_profile_path
  end

  
  #if registration is not successful

  def then_user_is_redirected_to_users_page
    expect(page.current_path).to eq '/users'
  end



end

  