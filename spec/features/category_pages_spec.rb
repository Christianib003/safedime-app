require 'rails_helper'

RSpec.feature 'categories page', type: :feature do
  before(:each) do
    @user = create(:user)
    @categories = create_list(:category, 3, user: @user)
    login_as(@user)
    visit root_path
  end

  scenario 'can see the categories, their icons, their name' do
    expect(page).to have_content(@categories.first.name)
    expect(page).to have_css("img[src*='#{@categories.first.icon}']")
  end

  scenario 'clicking one category, redirect to category payments show page' do
    click_link(@categories.first.name)
    expect(page).to have_current_path(category_path(@categories.first))
  end
  scenario 'clicking new category, redirect to category new page' do
    click_link('New Category')
    expect(page).to have_current_path(new_category_path)
  end
end
