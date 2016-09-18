require 'rails_helper'

describe Api::StatisticsController do
  describe 'GET activity_per_category' do
    context 'with date_from and date_to' do
      let(:date_from) { '2011-01-01' }
      let(:date_to) { '2011-01-05' }
      let(:expected_range) { Date.parse(date_from)..Date.parse(date_to) }

      it 'use the date range' do
        expect(Statistics::ActivityPerCategory).to receive(:new).with(expected_range).and_call_original
        get :activity_per_category, date_from: date_from, date_to: date_to

        date_range = assigns(:activity_per_category).date_range
        expect(date_range).to eq expected_range
      end
    end

    context 'with date' do
      let(:date) { '2011-01-01' }
      let(:expected_range) { Date.parse(date).beginning_of_month..Date.parse(date).end_of_month }

      it 'use the date range' do
        expect(Statistics::ActivityPerCategory).to receive(:new).with(expected_range).and_call_original
        get :activity_per_category, date: date

        date_range = assigns(:activity_per_category).date_range
        expect(date_range).to eq expected_range
      end
    end

    context 'with no date' do
      let(:expected_range) { Date.today.beginning_of_month.to_date..Date.today.end_of_month.to_date }
      it 'use the date range' do
        expect(Statistics::ActivityPerCategory).to receive(:new).with(expected_range).and_call_original
        get :activity_per_category

        date_range = assigns(:activity_per_category).date_range
        expect(date_range).to eq expected_range
      end
    end
  end

  describe 'GET activity_per_category_type' do
    context 'with date_from and date_to' do
      let(:date_from) { '2011-01-01' }
      let(:date_to) { '2011-01-05' }
      let(:expected_range) { Date.parse(date_from)..Date.parse(date_to) }

      it 'use the date range' do
        expect(Statistics::ActivityPerCategoryType).to receive(:new).with(expected_range).and_call_original
        get :activity_per_category_type, date_from: date_from, date_to: date_to

        date_range = assigns(:activity_per_category_type).date_range
        expect(date_range).to eq expected_range
      end
    end

    context 'with date' do
      let(:date) { '2011-01-01' }
      let(:expected_range) { Date.parse(date).beginning_of_month..Date.parse(date).end_of_month }

      it 'use the date range' do
        expect(Statistics::ActivityPerCategoryType).to receive(:new).with(expected_range).and_call_original
        get :activity_per_category_type, date: date

        date_range = assigns(:activity_per_category_type).date_range
        expect(date_range).to eq expected_range
      end
    end

    context 'with no date' do
      let(:expected_range) { Date.today.beginning_of_month.to_date..Date.today.end_of_month.to_date }
      it 'use the date range' do
        expect(Statistics::ActivityPerCategoryType).to receive(:new).with(expected_range).and_call_original
        get :activity_per_category_type

        date_range = assigns(:activity_per_category_type).date_range
        expect(date_range).to eq expected_range
      end
    end
  end
end
