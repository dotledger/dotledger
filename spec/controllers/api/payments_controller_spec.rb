require 'rails_helper'

describe Api::PaymentsController do
  let!(:category) { FactoryGirl.create :category }

  let!(:payment) { FactoryGirl.create :payment, category: category, amount: 10.00 }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all payments' do
      expect(assigns(:payments)).to eq [payment]
    end
  end

  describe 'GET show' do
    before { get :show, id: payment.id }

    it { should respond_with :success }

    it 'returns the payment' do
      expect(assigns(:payment)).to eq payment
    end
  end

  describe 'POST create' do
    def valid_request
      post :create,
           name: 'Some Payment',
           type: 'Spend',
           amount: 1000,
           category_id: category.id
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates a payment' do
      expect do
        valid_request
      end.to change(Payment, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update,
          id: payment.id,
          amount: 500
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'updates the amount' do
      expect do
        valid_request
      end.to change { payment.reload.amount }.from(10.0).to(500)
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
             id: payment.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the payment' do
      expect do
        valid_request
      end.to change(Payment, :count).by(-1)
    end
  end
end
