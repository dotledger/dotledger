require 'rails_helper'

feature 'Sorting Rules', truncate: true, js: true do
  let!(:category) do
    FactoryGirl.create :category,
      name: 'Test Category'
  end

  let!(:sorting_rule1) do
    FactoryGirl.create :sorting_rule,
      contains: 'foo',
      name: 'Foobar',
      category: category,
      review: true
  end

  let!(:sorting_rule2) do
    FactoryGirl.create :sorting_rule,
      contains: 'baz',
      name: 'Bazbar',
      category: category,
      review: false
  end

  describe 'Index' do
    before do
      visit '/sorting-rules'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Sorting Rules'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Sorting Rules'
    end

    it 'shows the sorting-rules' do
      expect(page).to have_content 'foo'
      expect(page).to have_content 'Foobar'
      expect(page).to have_link 'Edit', href: "/sorting-rules/#{sorting_rule1.id}/edit"

      expect(page).to have_content 'baz'
      expect(page).to have_content 'Bazbar'
      expect(page).to have_link 'Edit', href: "/sorting-rules/#{sorting_rule2.id}/edit"
    end
  end

  describe 'Create' do
    before do
      visit '/sorting-rules/new'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'New Sorting Rule'
    end

    it 'shows the heading' do
      expect(page).to have_content 'New Sorting Rule'
    end

    it 'shows the form' do
      expect(page).to have_field 'Contains'
      expect(page).to have_field 'Name'
      expect(page).to have_field 'Category'
      expect(page).to have_field 'Flag matches for review'
      expect(page).to have_field 'Tags'
      expect(page).to have_button 'Save'
      expect(page).to have_link 'Cancel', href: '/sorting-rules'
    end

    it 'creates a new sorting_rule' do
      expect {
        fill_in 'Contains', with: 'test'
        fill_in 'Name', with: 'Test Rule'
        select 'Test Category', from: 'Category'

        click_button 'Save'

        expect(page).to have_content 'test'
        expect(page).to have_content 'Test Rule'
      }.to change { SortingRule.count }.by(1)
    end
  end

  describe 'Update' do
    before do
      visit "/sorting-rules/#{sorting_rule1.id}/edit"
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Edit Sorting Rule', 'foo'
    end

    it 'shows the heading' do
      expect(page.find('.page-header')).to have_content 'Foobar'
    end

    it 'shows the form' do
      expect(find_field('Contains').value).to eq 'foo'
      expect(find_field('Name').value).to eq 'Foobar'
      expect(find_field('Category').value).to eq category.id.to_s
      expect(find_field('Flag matches for review').value).to eq 'true'
      expect(page).to have_button 'Save'
      expect(page).to have_link 'Cancel', href: '/sorting-rules'
    end

    it 'updates an existing sorting_rule' do
      expect {
        fill_in 'Name', with: 'New Sorting Rule Name'

        click_button 'Save'

        expect(page).to have_content 'New Sorting Rule Name'

        sorting_rule1.reload
      }.to change { sorting_rule1.name }.from('Foobar').to('New Sorting Rule Name')
    end
  end
end
