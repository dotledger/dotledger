require 'spec_helper'

feature "Dashboard", :truncate => true, :js => true do
  let!(:account_1) { FactoryGirl.create :account, :name => "Test Account 1", :balance => 2000.00 }
  let!(:account_2) { FactoryGirl.create :account, :name => "Test Account 2", :balance => 123.45 }
  let!(:account_3) { FactoryGirl.create :account, :name => "Test Account 3", :balance => -500.00 }
  let!(:unsorted_transaction) { FactoryGirl.create :transaction, :account => account_1 }

  before do
    visit "/"
  end

  it "shows the heading" do
    expect(page).to have_content "Dashboard"
    expect(page).to have_content "My finances"
  end

  it "shows the accounts" do
    expect(page).to have_content "Test Account 1"
    expect(page).to have_content "Test Account 2"
    expect(page).to have_content "Test Account 3"
  end

  it "shows the accout balances" do
    expect(page).to have_content "$2,000.00"
    expect(page).to have_content "$123.45"
    expect(page).to have_content "$-500.00"
  end

  it "shows the balance summary" do
    expect(page).to have_content "Total cash: $2,123.45"
    expect(page).to have_content "Total debt: $500.00"
    expect(page).to have_content "Difference: $1,623.45"
  end

  it "shows the unsorted transactions link" do
    expect(page).to have_link "1 unsorted", :href => "/accounts/#{account_1.id}/unsorted"
  end
end
