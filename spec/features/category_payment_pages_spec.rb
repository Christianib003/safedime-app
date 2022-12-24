require 'rails_helper'

RSpec.feature 'category_payments page', type: :feature do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user: @user)
    @payments = create_list(:payment, 3, user_id: @user.id)
    @payments.each do |payment|
      payment.categories << @category
    end
    login_as(@user)
    visit category_path(@category.id)
  end

  scenario 'can see the payments,their names and amount' do
    expect(page).to have_content(@payments.first.name)
    expect(page).to have_content(@payments.last.name)
    expect(page).to have_content(@payments.first.amount)
  end

  scenario 'clicking new payment, redirect to category_payment new page' do
    click_link('New Payment')
    expect(page).to have_current_path(new_category_payment_path(category_id: @category.id))
  end
end
