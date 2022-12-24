require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  before(:each) do
    @current_user = create(:user)
    @category = create(:category, user: @current_user)
    login_as(@current_user)
  end

  describe 'GET /categories/new' do
    it 'renders a successful response' do
      get new_category_payment_path(category_id: @category.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) { { name: 'name', amount: 9.99, user: @current_user } }
    context 'with valid parameters' do
      it 'creates a new payment' do
        expect do
          post category_payments_path(category_id: @category.id), params: { payment: valid_attributes }
        end.to change(Payment, :count).by(1)
      end
    end
  end
end
