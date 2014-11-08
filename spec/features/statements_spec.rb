require 'rails_helper'

feature "Statements", truncate: true, js: true do
  describe "Create" do
    let!(:account) do
      FactoryGirl.create :account,
        name: "Test Account 1",
        balance: 2000.00,
        number: "12-3456-1234567-123",
        type: "Savings"
    end

    before do
      visit "/accounts/#{account.id}/import"
    end

    it "sets the correct page title" do
      expect_page_title_to_be 'New Statement', 'Test Account 1'
    end

    it "shows the heading" do
      expect(page).to have_content "Import Statement"
    end

    it "shows the sub-heading" do
      expect(page).to have_content "Test Account 1"
    end

    it "shows the form" do
      expect(page).to have_field "File"
      expect(page).to have_button "Import"
      expect(page).to have_link "Cancel", href: "/accounts/#{account.id}"
    end
  end
end
