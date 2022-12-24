require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:each) do
    @current_user = create(:user)
    @category = create(:category, user: @current_user)
    login_as(@current_user)
  end
  describe 'GET /categories' do
    before(:each) do
      get categories_path
    end

    it 'responds with status 200' do
      expect(response).to have_http_status(200)
    end

    it 'renders the categories/index view' do
      expect(response).to render_template('categories/index')
    end

    context 'with render_views enabled' do
      it 'renders view with text in the index template' do
        expect(response.body).to include(@category.name)
      end
    end
  end

  describe 'GET /categories/:id' do
    before :each do
      get category_path(id: @category.id)
    end

    it 'responds with status 200' do
      expect(response).to have_http_status(200)
    end

    it 'renders the categories/show view' do
      expect(response).to render_template('categories/show')
    end

    context 'with render_views enabled' do
      it 'renders view with text in the show template' do
        expect(response.body).to include('Payments')
      end
    end
  end

  describe 'GET /categories/new' do
    it 'renders a successful response' do
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) { { name: 'name', icon: 'https://example.com', user: @current_user } }

    let(:invalid_attributes) { { icon: 'https://example.com', user: @current_user } }
    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post categories_url, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the categories list page' do
        post categories_url, params: { category: valid_attributes }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post categories_url, params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)
      end
    end
  end
end
