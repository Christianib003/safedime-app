require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user: @user)
  end
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(@category).to be_valid
    end
    it 'is not valid without a title' do
      @category.name = nil
      expect(@category).to_not be_valid
    end
  end
  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
