require 'spec_helper'

describe Api::GoalsController do
  let!(:category) { FactoryGirl.create :category }
  let!(:goal) { category.goal }

  describe "GET index" do
    before { get :index }

    it { should respond_with :success }

    it "should return all goals" do
      expect(assigns(:goals)).to eq [goal]
    end
  end

  describe "GET show" do
    before { get :show, :id => goal.id }

    it { should respond_with :success }

    it "should return the goal" do
      expect(assigns(:goal)).to eq goal
    end
  end

  describe "POST create" do
    def valid_request
      post :create,
        :amount => 1000,
        :category_id => category.id
    end

    it "should respond with 200" do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it "should create a goal" do
      expect {
        valid_request
      }.to change(Goal, :count).by(1)
    end
  end

  describe "PUT update" do
    def valid_request
      put :update,
        :id => goal.id,
        :amount => 500 
    end

    it "should respond with 200" do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it "should update the amount" do
      expect {
        valid_request
      }.to change {goal.reload.amount}.from(0.0).to(500)
    end
  end

  describe "DELETE destroy" do
    def valid_request
      delete :destroy,
        :id => goal.id
    end

    it "should respond with 204" do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it "should delete the goal" do
      expect {
        valid_request
      }.to change(Goal, :count).by(-1)
    end
  end
end
