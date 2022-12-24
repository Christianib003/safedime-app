require 'rails_helper'

RSpec.feature 'Log in session', type: :feature do
  before(:each) do
    visit new_user_session_path
    @user = create(:user)
  end
  scenario 'can see the inputs' do
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  scenario 'submit without filling all inputs, raise error' do
    fill_in('Email', with: nil)
    fill_in('Password', with: nil)
    click_button('Log in')
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'submit with incorrect data, raise error' do
    fill_in('Email', with: 'user@example.com')
    fill_in('Password', with: 'password')
    click_button('Log in')
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'submit with correct data, redirect to root page' do
    fill_in('Email', with: @user.email)
    fill_in('Password', with: @user.password)
    click_button('Log in')
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Signed in successfully')
  end
end
