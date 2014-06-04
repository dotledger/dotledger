require 'rails_helper'

describe Api::StatisticsController do
  describe "GET activity_per_category" do
    context "with date_from and date_to" do
      let(:date_from) { '2011-01-01' }
      let(:date_to) { '2011-01-05' }

      it "use the date range" do
        get :activity_per_category, :date_from => date_from, :date_to => date_to

        date_range = assigns(:activity_per_category).date_range
        expect(date_range).to eq Date.parse(date_from)..Date.parse(date_to)
      end
    end

    context "with date" do
      let(:date) { '2011-01-01' }

      it "use the date range" do
        get :activity_per_category, :date => date

        date_range = assigns(:activity_per_category).date_range
        expect(date_range).to eq Date.parse(date).beginning_of_month..Date.parse(date).end_of_month
      end
    end

    context "with no date" do
      it "use the date range" do
        get :activity_per_category

        date_range = assigns(:activity_per_category).date_range
        expect(date_range).to eq Date.today.beginning_of_month.to_date..Date.today.end_of_month.to_date
      end
    end
  end
end
