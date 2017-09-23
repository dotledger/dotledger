require 'rails_helper'

describe Api::SortedTransactionsController do
  let!(:sorted_transaction) { FactoryGirl.create :sorted_transaction, name: 'Sorted Transaction Name' }
  let!(:account) { FactoryGirl.create :account }
  let!(:transaction) { FactoryGirl.create :transaction, account: account }
  let!(:category) { FactoryGirl.create :category }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all sorted_transactions' do
      expect(assigns(:sorted_transactions)).to match_array [sorted_transaction]
    end
  end

  describe 'GET show' do
    before { get :show, id: sorted_transaction.id }

    it { should respond_with :success }

    it 'returns the sorted_transaction' do
      expect(assigns(:sorted_transaction)).to eq sorted_transaction
    end
  end

  describe 'POST create' do
    def valid_request
      attributes = FactoryGirl.attributes_for(:sorted_transaction)
      attributes[:account_id] = account.id
      attributes[:transaction_id] = transaction.id
      attributes[:category_id] = category.id
      post :create, attributes
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates a sorted_transaction' do
      expect do
        valid_request
      end.to change(SortedTransaction, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update,
        id: sorted_transaction.id,
        name: 'New Sorted Transaction Name'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'updates the name' do
      expect do
        valid_request
      end.to change { sorted_transaction.reload.name }.from('Sorted Transaction Name').to('New Sorted Transaction Name')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
        id: sorted_transaction.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the sorted_transaction' do
      expect do
        valid_request
      end.to change(SortedTransaction, :count).by(-1)
    end
  end
end
