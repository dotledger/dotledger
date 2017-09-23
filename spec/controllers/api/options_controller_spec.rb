require 'rails_helper'

describe Api::OptionsController do
  describe 'GET options' do
    before { get :options }

    it { should respond_with :success }

    it 'returns all options' do
      expect(response.body).to eq(
        {
          account_types: Account::ACCOUNT_TYPES,
          category_types: Category::CATEGORY_TYPES,
          goal_periods: Goal::GOAL_PERIODS,
          goal_types: Goal::GOAL_TYPES,
          payment_types: Payment::PAYMENT_TYPES,
          payment_periods: Payment::PAYMENT_PERIODS
        }.to_json
      )
    end
  end

  describe 'GET account_types' do
    before { get :account_types }

    it { should respond_with :success }

    it 'returns all account_types' do
      expect(response.body).to eq(
        {
          account_types: Account::ACCOUNT_TYPES
        }.to_json
      )
    end
  end

  describe 'GET category_types' do
    before { get :category_types }

    it { should respond_with :success }

    it 'returns all category_types' do
      expect(response.body).to eq(
        {
          category_types: Category::CATEGORY_TYPES
        }.to_json
      )
    end
  end

  describe 'GET goal_periods' do
    before { get :goal_periods }

    it { should respond_with :success }

    it 'returns all goal_periods' do
      expect(response.body).to eq(
        {
          goal_periods: Goal::GOAL_PERIODS
        }.to_json
      )
    end
  end

  describe 'GET goal_types' do
    before { get :goal_types }

    it { should respond_with :success }

    it 'returns all goal_types' do
      expect(response.body).to eq(
        {
          goal_types: Goal::GOAL_TYPES
        }.to_json
      )
    end
  end

  describe 'GET payment_types' do
    before { get :payment_types }

    it { should respond_with :success }

    it 'returns all payment_types' do
      expect(response.body).to eq(
        {
          payment_types: Payment::PAYMENT_TYPES
        }.to_json
      )
    end
  end

  describe 'GET payment_periods' do
    before { get :payment_periods }

    it { should respond_with :success }

    it 'returns all payment_periods' do
      expect(response.body).to eq(
        {
          payment_periods: Payment::PAYMENT_PERIODS
        }.to_json
      )
    end
  end
end
