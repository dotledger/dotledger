require 'rails_helper'

feature "Accounts", :truncate => true, :js => true do
  describe "Show" do
    let(:account) do
      FactoryGirl.create :account,
        :name => "Test Account 1",
        :balance => 2000.00,
        :number => "12-3456-1234567-123",
        :type => "Savings"
    end

    background do
      FactoryGirl.create :transaction,
        :name => "Test Unsorted Transaction",
        :posted_at => Date.parse("2012-10-13"),
        :account => account,
        :amount => 19.95

      FactoryGirl.create :transaction_review,
        :name => "Test Review Transaction",
        :posted_at => Date.parse("2012-10-14"),
        :account => account,
        :amount => 234.56

      FactoryGirl.create :transaction_sorted,
        :name => "Test Sorted Transaction",
        :posted_at => Date.parse("2012-10-15"),
        :account => account,
        :amount => -1000.00
    end

    before do
      visit "/accounts/#{account.id}"
    end

    it "shows the account name" do
      expect(page).to have_content "Test Account 1"
    end

    it "shows the account type" do
      expect(page).to have_content "Savings"
    end

    it "shows the account number" do
      expect(page).to have_content "12-3456-1234567-123"
    end

    it "shows the sorted tab label" do
      expect(page).to have_content "Sorted 1"
    end

    it "shows the review tab label" do
      expect(page).to have_content "Review 1"
    end

    it "shows the unsorted tab label" do
      expect(page).to have_content "Unsorted 1"
    end

    describe "Unsorted Transactions" do
      before do
        click_on "Unsorted"
      end

      it "shows the transaction name" do
        expect(page).to have_content "Test Unsorted Transaction"
      end

      it "shows the transaction date" do
        expect(page).to have_content "13 Oct 2012"
      end

      it "shows the transaction amount" do
        expect(page).to have_content "$19.95"
      end
    end

    describe "Review Transactions" do
      before do
        click_on "Review"
      end

      it "shows the transaction name" do
        expect(page).to have_content "Test Review Transaction"
      end

      it "shows the transaction date" do
        expect(page).to have_content "14 Oct 2012"
      end

      it "shows the transaction amount" do
        expect(page).to have_content "$234.56"
      end
    end

    describe "Sorted Transactions" do
      before do
        click_on "Sorted"
      end

      it "shows the transaction name" do
        expect(page).to have_content "Test Sorted Transaction"
      end

      it "shows the transaction date" do
        expect(page).to have_content "15 Oct 2012"
      end

      it "shows the transaction amount" do
        expect(page).to have_content "$1,000.00"
      end
    end
  end

  describe "Create" do
    before do
      visit "/accounts/new"
    end

    it "shows the heading" do
      expect(page).to have_content "New Account"
    end

    it "shows the form" do
      expect(page).to have_field "Name"
      expect(page).to have_field "Number"
      expect(page).to have_field "Type"
      expect(page).to have_button "Save"
      expect(page).to have_link "Cancel", :href => "/"
    end

    it "creates a new account" do
      expect {
        fill_in "Name", :with => "Test Account"
        fill_in "Number", :with => "12-1234-1234567-123"
        select "Savings", :from => "Type"

        click_button "Save"

        expect(page).to have_content "Test Account"
      }.to change { Account.count }.by(1)
    end
  end

  describe "Update" do
    let(:account) do
      FactoryGirl.create :account,
        :name => "Test Account",
        :balance => 2000.00,
        :number => "12-3456-1234567-123",
        :type => "Savings"
    end

    before do
      visit "/accounts/#{account.id}/edit"
    end

    it "shows the heading" do
      expect(page).to have_content "Test Account"
    end

    it "shows the form" do
      expect(find_field("Name").value).to eq "Test Account"
      expect(find_field("Number").value).to eq "12-3456-1234567-123"
      expect(find_field("Type").value).to eq "Savings"
      expect(page).to have_button "Save"
      expect(page).to have_link "Cancel", :href => "/accounts/#{account.id}"
    end

    it "updates an existing account" do
      expect {
        fill_in "Name", :with => "New Account Name"

        click_button "Save"

        expect(page).to have_content "New Account Name"

        account.reload
      }.to change { account.name }.from("Test Account").to("New Account Name")
    end
  end
end
