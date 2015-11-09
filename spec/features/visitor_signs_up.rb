  require 'rails_helper'

  RSpec.feature 'Visitor signs up' do 

    scenario 'with valid email and password' do 

      visit new_user_registration_path
      fill_in "user_email", with: 'philippe@600px.fr'
      fill_in "user_password", with: 'solodugrandb'
      fill_in "user_password_confirmation", with: 'solodugrandb'
      click_button 'Sign up'
      expect(page.current_path).to eq root_path

    end

    scenario 'with invalid email or password' do 

      visit new_user_registration_path
      fill_in "user_email", with: 'philipp@'
      fill_in "user_password", with: 'solodugrandb'
      fill_in "user_password_confirmation", with: 'solodugrandb'
      click_button 'Sign up'
      expect(page.current_path).to eq "/users"
      expect(page).to have_content "Please review the problems below:"

    end


  end

  