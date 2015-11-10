require 'rails_helper'

RSpec.feature 'Visitor signs up' do 

  scenario 'Visitor signs up with valid emails and password' do
    as_a_visitor_when_i_visit_the_registration_page
    and_fill_in_the_sign_up_form
    and_click_sign_up
    i_should_be_redirected_to_home_page
  end

  scenario 'Visitor signs up with invalid email or password' do
    as_a_visitor_when_i_visit_the_registration_page
    and_fill_in_the_sign_up_form_with_invalid_email
    and_click_sign_up
    i_should_be_redirected_to_users_page
  end

  def as_a_visitor_when_i_visit_the_registration_page
    visit new_user_registration_path
  end

  def and_fill_in_the_sign_up_form
    fill_in "user_email", with: 'philippe@600px.fr'
    fill_in "user_password", with: 'solodugrandb'
    fill_in "user_password_confirmation", with: 'solodugrandb'
  end

  def and_fill_in_the_sign_up_form_with_invalid_email
    fill_in "user_email", with: 'philippe'
    fill_in "user_password", with: 'solodugrandb'
    fill_in "user_password_confirmation", with: 'solodugrandb'
  end

  def and_click_sign_up
    click_button 'Sign up'
  end

  def i_should_be_redirected_to_home_page
    expect(page.current_path).to eq root_path
  end

  def i_should_be_redirected_to_users_page
    expect(page.current_path).to eq '/users'
  end



end

  