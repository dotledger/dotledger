require 'rails_helper'

describe Api::CategoriesController do
  let!(:category) { FactoryGirl.create :category, name: 'Category' }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'should return all categories' do
      expect(assigns(:categories)).to eq [category]
    end
  end

  describe 'GET show' do
    before { get :show, id: category.id }

    it { should respond_with :success }

    it 'should return the category' do
      expect(assigns(:category)).to eq category
    end
  end

  describe 'POST create' do
    def valid_request
      post :create,
        name: 'Category Name',
        type: 'Essential'
    end

    it 'should respond with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'should create a category' do
      expect {
        valid_request
      }.to change(Category, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update,
        id: category.id,
        name: 'New Category Name'
    end

    it 'should respond with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'should update the name' do
      expect {
        valid_request
      }.to change {category.reload.name}.from('Category').to('New Category Name')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
        id: category.id
    end

    it 'should respond with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'should delete the category' do
      expect {
        valid_request
      }.to change(Category, :count).by(-1)
    end
  end
end
