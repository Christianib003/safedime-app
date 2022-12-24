require 'rails_helper'

RSpec.describe Payment, type: :model do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user: @user)
    @payment = create(:payment, user: @user)
    @payment.categories << @category
  end
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(@payment).to be_valid
    end
    it 'is not valid without a title' do
      @payment.name = nil
      expect(@payment).to_not be_valid
    end
  end
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:categories) }
  end
end
