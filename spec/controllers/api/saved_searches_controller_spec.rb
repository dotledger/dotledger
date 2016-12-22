require 'rails_helper'

describe Api::SavedSearchesController do
  let!(:saved_search) { FactoryBot.create :saved_search, name: 'Saved Search' }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all saved_searches' do
      expect(assigns(:saved_searches)).to eq [saved_search]
    end
  end

  describe 'GET show' do
    before { get :show, id: saved_search.id }

    it { should respond_with :success }

    it 'returns the account group' do
      expect(assigns(:saved_search)).to eq saved_search
    end
  end

  describe 'POST create' do
    def valid_request
      post :create, name: 'Other Saved Search'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates an account group' do
      expect do
        valid_request
      end.to change(SavedSearch, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update, id: saved_search.id, name: 'New Saved Search'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'updates the name' do
      expect do
        valid_request
      end.to change { saved_search.reload.name }.from('Saved Search').to('New Saved Search')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy, id: saved_search.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the account group' do
      expect do
        valid_request
      end.to change(SavedSearch, :count).by(-1)
    end
  end
end
