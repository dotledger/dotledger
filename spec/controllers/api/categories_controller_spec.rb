require 'rails_helper'

describe Api::CategoriesController do
  let!(:category) { FactoryGirl.create :category, name: 'Category' }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all categories' do
      expect(assigns(:categories)).to eq [category]
    end
  end

  describe 'GET show' do
    before { get :show, id: category.id }

    it { should respond_with :success }

    it 'returns the category' do
      expect(assigns(:category)).to eq category
    end
  end

  describe 'POST create' do
    def valid_request
      post :create,
           name: 'Category Name',
           type: 'Essential'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates a category' do
      expect do
        valid_request
      end.to change(Category, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update,
          id: category.id,
          name: 'New Category Name'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'updates the name' do
      expect do
        valid_request
      end.to change { category.reload.name }.from('Category').to('New Category Name')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
             id: category.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the category' do
      expect do
        valid_request
      end.to change(Category, :count).by(-1)
    end
  end
end
