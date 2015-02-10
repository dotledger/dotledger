require 'rails_helper'

describe Api::StatementsController do
  let!(:statement) { FactoryGirl.create :statement }
  let!(:account) { FactoryGirl.create :account }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all statements' do
      expect(assigns(:statements)).to eq [statement]
    end
  end

  describe 'GET show' do
    before { get :show, id: statement.id }

    it { should respond_with :success }

    it 'returns the statement' do
      expect(assigns(:statement)).to eq statement
    end
  end

  describe 'POST create' do
    def valid_request
      post :create, account_id: account.id,
        file: fixture_file_upload('example.ofx')
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates a statement' do
      expect do
        valid_request
      end.to change(Statement, :count).by(1)
    end

    it 'creates 4 transaction' do
      expect do
        valid_request
      end.to change(Transaction, :count).by(4)
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
             id: statement.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the statement' do
      expect do
        valid_request
      end.to change(Statement, :count).by(-1)
    end
  end
end
