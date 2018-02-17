require 'rails_helper'

describe Api::AccountGroupsController do
  let!(:account_group) { FactoryBot.create :account_group, name: 'Account Group' }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all account_groups' do
      expect(assigns(:account_groups)).to eq [account_group]
    end
  end

  describe 'GET show' do
    before { get :show, id: account_group.id }

    it { should respond_with :success }

    it 'returns the account group' do
      expect(assigns(:account_group)).to eq account_group
    end
  end

  describe 'POST create' do
    def valid_request
      post :create, name: 'Other Account Group'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates an account group' do
      expect do
        valid_request
      end.to change(AccountGroup, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update, id: account_group.id, name: 'New Account Group'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'updates the name' do
      expect do
        valid_request
      end.to change { account_group.reload.name }.from('Account Group').to('New Account Group')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy, id: account_group.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the account group' do
      expect do
        valid_request
      end.to change(AccountGroup, :count).by(-1)
    end
  end
end
