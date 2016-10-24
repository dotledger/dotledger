require 'rails_helper'

describe Api::GoalsController do
  let!(:category) { FactoryGirl.create :category }
  let!(:goal) { category.goal }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all goals' do
      expect(assigns(:goals)).to eq [goal]
    end
  end

  describe 'GET show' do
    before { get :show, id: goal.id }

    it { should respond_with :success }

    it 'returns the goal' do
      expect(assigns(:goal)).to eq goal
    end
  end

  describe 'POST create' do
    def valid_request
      post :create,
           amount: 1000,
           category_id: category.id
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'creates a goal' do
      expect do
        valid_request
      end.to change(Goal, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update,
          id: goal.id,
          amount: 500,
          type: 'Receive',
          period: 'Week'
    end

    it 'responds with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'updates the amount' do
      expect do
        valid_request
      end.to change { goal.reload.amount }.from(0.0).to(500)
    end

    it 'updates the type' do
      expect do
        valid_request
      end.to change { goal.reload.type }.from('Spend').to('Receive')
    end

    it 'updates the period' do
      expect do
        valid_request
      end.to change { goal.reload.period }.from('Month').to('Week')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
             id: goal.id
    end

    it 'responds with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'deletes the goal' do
      expect do
        valid_request
      end.to change(Goal, :count).by(-1)
    end
  end
end
