require 'rails_helper'

describe Api::SortingRulesController do
  let!(:sorting_rule) { FactoryGirl.create :sorting_rule, name: 'Some Name' }
  let!(:category) { FactoryGirl.create :category }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'should return all sorting_rules' do
      expect(assigns(:sorting_rules)).to eq [sorting_rule]
    end
  end

  describe 'GET show' do
    before { get :show, id: sorting_rule.id }

    it { should respond_with :success }

    it 'should return the sorting_rule' do
      expect(assigns(:sorting_rule)).to eq sorting_rule
    end
  end

  describe 'POST create' do
    def valid_request
      post :create,
        name: 'New Name',
        contains: 'Foobar',
        category_id: category.id
    end

    it 'should respond with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'should create a sorting_rule' do
      expect {
        valid_request
      }.to change(SortingRule, :count).by(1)
    end
  end

  describe 'PUT update' do
    def valid_request
      put :update,
        id: sorting_rule.id,
        name: 'Some New Name'
    end

    it 'should respond with 200' do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it 'should update the name' do
      expect {
        valid_request
      }.to change {sorting_rule.reload.name}.from('Some Name').to('Some New Name')
    end
  end

  describe 'DELETE destroy' do
    def valid_request
      delete :destroy,
        id: sorting_rule.id
    end

    it 'should respond with 204' do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it 'should delete the sorting_rule' do
      expect {
        valid_request
      }.to change(SortingRule, :count).by(-1)
    end
  end
end
