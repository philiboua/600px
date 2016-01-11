require 'rails_helper'

RSpec.feature 'User logout' do 

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
    @profile = create(:profile, user_id: @user.id)
  end

  scenario 'a user can upload photos' do 
    given_the_home_page_is_open
    when_the_user_clicks_on_logout
    then_user_is_redirected_to_signin_page
  end

  def given_the_home_page_is_open
    visit root_path
  end

  def when_the_user_clicks_on_logout
    find(".user-name").click
    click_link("log out")
  end

  def then_user_is_redirected_to_signin_page
    expect(page.current_path).to eq(root_path)
  end 


end

