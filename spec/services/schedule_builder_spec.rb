require 'spec_helper'

describe ScheduleBuilder do
  subject { ScheduleBuilder.new(params).build }
  let(:year_start) { Date.parse('2012-01-01').beginning_of_year }
  let(:year_end) { Date.parse('2012-01-01').end_of_year }

  describe "no repeat" do
    let(:params) do
      {
        :repeat => false,
        :date => '2011-03-06'
      }
    end

    it "does not repeat" do
      expect(subject.recurrence_rules).to be_empty
    end

    it "sets the correct date" do
      expect(subject.start_time.to_date).to eq Date.parse('2011-03-06')
    end
  end

  describe "repeat" do
    context "monthly" do
      let(:params) do
        {
          :date => '2011-03-06',
          :repeat => 'true',
          :repeat_interval => 12,
          :repeat_period => 'Month'
        }
      end

      it "repeats" do
        expect(subject.recurrence_rules).to_not be_empty
      end

      it "sets the correct date" do
        expect(subject.start_time.to_date).to eq Date.parse('2011-03-06')
      end

      it "sets the correct recurrence rule type" do
        expect(subject.recurrence_rules.first.class).to eq IceCube::MonthlyRule
      end

      it "sets the correct recurrence interval" do
        expect(subject.recurrence_rules.first.instance_variable_get(:@interval)).to eq 12
      end

      it "repeats correctly" do
        expect(subject.occurrences_between(year_start, year_end).size).to eq 1
      end
    end

    context "weekly" do
      let(:params) do
        {
          :date => '2011-02-18',
          :repeat => 'true',
          :repeat_interval => 2,
          :repeat_period => 'Week'
        }
      end

      it "repeats" do
        expect(subject.recurrence_rules).to_not be_empty
      end

      it "sets the correct date" do
        expect(subject.start_time.to_date).to eq Date.parse('2011-02-18')
      end

      it "sets the correct recurrence rule type" do
        expect(subject.recurrence_rules.first.class).to eq IceCube::WeeklyRule
      end

      it "sets the correct recurrence interval" do
        expect(subject.recurrence_rules.first.instance_variable_get(:@interval)).to eq 2
      end

      it "repeats correctly" do
        expect(subject.occurrences_between(year_start, year_end).size).to eq 26
      end
    end

    context "daily" do
      let(:params) do
        {
          :date => '2011-06-12',
          :repeat => 'true',
          :repeat_interval => 1,
          :repeat_period => 'Day'
        }
      end

      it "repeats" do
        expect(subject.recurrence_rules).to_not be_empty
      end

      it "sets the correct date" do
        expect(subject.start_time.to_date).to eq Date.parse('2011-06-12')
      end

      it "sets the correct recurrence rule type" do
        expect(subject.recurrence_rules.first.class).to eq IceCube::DailyRule
      end

      it "sets the correct recurrence interval" do
        expect(subject.recurrence_rules.first.instance_variable_get(:@interval)).to eq 1
      end

      it "repeats correctly" do
        expect(subject.occurrences_between(year_start, year_end).size).to eq 366
      end
    end
 end
end
