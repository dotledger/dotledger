require 'rails_helper'

feature "Categories", truncate: true, js: true do
  let!(:category1) do
    FactoryGirl.create :category,
      name: 'Test Category 1',
      type: 'Essential'
  end

  let!(:category2) do
    FactoryGirl.create :category,
      name: 'Test Category 2',
      type: 'Flexible'
  end

  describe "Index" do
    before do
      visit "/categories"
    end

    it "sets the correct page title" do
      expect_page_title_to_be 'Categories'
    end

    it "shows the heading" do
      expect(page).to have_content "Categories"
    end

    it "shows the categories" do
      expect(page.find("#category-type-essential")).to have_content "Test Category 1"
      expect(page.find("#category-type-essential")).to have_link "Edit", href: "/categories/#{category1.id}/edit"

      expect(page.find("#category-type-flexible")).to have_content "Test Category 2"
      expect(page.find("#category-type-flexible")).to have_link "Edit", href: "/categories/#{category2.id}/edit"
    end
  end

  describe "Create" do
    before do
      visit "/categories/new"
    end

    it "sets the correct page title" do
      expect_page_title_to_be 'New Category'
    end

    it "shows the heading" do
      expect(page).to have_content "New Category"
    end

    it "shows the form" do
      expect(page).to have_field "Name"
      expect(page).to have_field "Type"
      expect(page).to have_button "Save"
      expect(page).to have_link "Cancel", href: "/categories"
    end

    it "creates a new category" do
      expect {
        fill_in "Name", with: "Some Category"
        select "Essential", from: "Type"

        click_button "Save"

        expect(page).to have_content "Some Category"
      }.to change { Category.count }.by(1)
    end
  end

  describe "Update" do
    before do
      visit "/categories/#{category1.id}/edit"
    end

    it "sets the correct page title" do
      expect_page_title_to_be 'Edit Category', 'Test Category 1'
    end

    it "shows the heading" do
      expect(page).to have_content "Test Category 1"
    end

    it "shows the form" do
      expect(find_field("Name").value).to eq "Test Category 1"
      expect(find_field("Type").value).to eq "Essential"
      expect(page).to have_button "Save"
      expect(page).to have_link "Cancel", href: "/categories"
    end

    it "updates an existing category" do
      expect {
        fill_in "Name", with: "New Category Name"

        click_button "Save"

        expect(page).to have_content "New Category Name"

        category1.reload
      }.to change { category1.name }.from("Test Category 1").to("New Category Name")
    end
  end
end
