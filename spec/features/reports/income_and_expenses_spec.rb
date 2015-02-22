require 'rails_helper'

feature 'IncomeAndExpenses', truncate: true, js: true do
  describe 'Show' do
    let(:account) do
      FactoryGirl.create :account,
                         name: 'Test Account 1',
                         balance: 2000.00,
                         number: '12-3456-1234567-123',
                         type: 'Savings'
    end

    let!(:spent) do
      FactoryGirl.create :transaction_sorted,
                         name: 'Spent',
                         posted_at: Date.yesterday,
                         account: account,
                         amount: -1000.00
    end

    let!(:received) do
      FactoryGirl.create :transaction_sorted,
                         name: 'Received',
                         posted_at: Date.yesterday,
                         account: account,
                         amount: 3000.00
    end

    before do
      visit "/reports/income-and-expenses"
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Reports', 'Income and Expenses'
    end

    describe 'spent' do
      it 'shows the category' do
        expect(page).to have_content spent.sorted_transaction.category.name
      end

      it 'shows the amount' do
        expect(page).to have_content '$1,000.00'
      end
    end

    describe 'received' do
      it 'shows the category' do
        expect(page).to have_content received.sorted_transaction.category.name
      end

      it 'shows the amount' do
        expect(page).to have_content '$3,000.00'
      end
    end
  end
end
