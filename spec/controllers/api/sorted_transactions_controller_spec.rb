require 'spec_helper'

describe Api::SortedTransactionsController do
  let!(:sorted_transaction) { FactoryGirl.create :sorted_transaction, :name => 'Sorted Transaction Name' }
  let!(:account) { FactoryGirl.create :account }
  let!(:transaction) { FactoryGirl.create :transaction, :account => account }
  let!(:category) { FactoryGirl.create :category }

  describe "GET index" do
    before { get :index }

    it { should respond_with :success }

    it "should return all sorted_transactions" do
      expect(assigns(:sorted_transactions)).to match_array [sorted_transaction]
    end
  end

  describe "GET show" do
    before { get :show, :id => sorted_transaction.id }

    it { should respond_with :success }

    it "should return the sorted_transaction" do
      expect(assigns(:sorted_transaction)).to eq sorted_transaction
    end
  end

  describe "POST create" do
    def valid_request
      attributes = FactoryGirl.attributes_for(:sorted_transaction) 
      attributes.merge!(:account_id => account.id)
      attributes.merge!(:transaction_id => transaction.id)
      attributes.merge!(:category_id => category.id)
      post :create, attributes
    end

    it "should respond with 200" do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it "should create a sorted_transaction" do
      expect {
        valid_request
      }.to change(SortedTransaction, :count).by(1)
    end
  end

  describe "PUT update" do
    def valid_request
      put :update,
        :id => sorted_transaction.id,
        :name => 'New Sorted Transaction Name'
    end

    it "should respond with 200" do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it "should update the name" do
      expect {
        valid_request
      }.to change {sorted_transaction.reload.name}.from('Sorted Transaction Name').to('New Sorted Transaction Name')
    end
  end

  describe "DELETE destroy" do
    def valid_request
      delete :destroy,
        :id => sorted_transaction.id
    end

    it "should respond with 204" do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it "should delete the sorted_transaction" do
      expect {
        valid_request
      }.to change(SortedTransaction, :count).by(-1)
    end
  end
end
