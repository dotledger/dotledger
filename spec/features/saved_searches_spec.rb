require 'rails_helper'

feature 'SavedSearches', truncate: true, js: true do
  include ActionView::Helpers::NumberHelper

  let!(:saved_search) do
    FactoryBot.create :saved_search, name: 'Foobar Search'
  end

  describe 'Index' do
    before do
      visit '/saved-searches'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Saved Searches'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Saved Searches'
    end

    it 'shows the saved search name' do
      expect(page).to have_content 'Foobar'
    end
  end

  describe 'Create' do
    before do
      visit '/saved-searches/new'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'New Saved Search'
    end

    it 'shows the heading' do
      expect(page).to have_content 'New Saved Search'
    end

    it 'shows the form' do
      expect(page).to have_field 'Name'
      expect(page).to have_field 'Search for'
      expect(page).to have_field 'Category'
      expect(page).to have_field 'date_from'
      expect(page).to have_field 'date_to'
      expect(page).to have_field 'period_from'
      expect(page).to have_field 'period_to'
      expect(page).to have_field 'Tags'
      expect(page).to have_field 'Account'
      expect(page).to have_field 'Review'
      expect(page).to have_button 'Save'
      expect(page).to have_link 'Cancel', href: '/saved-searches'
    end

    it 'creates a new saved search' do
      expect do
        fill_in 'Name', with: 'Search 1'

        click_button 'Save'

        expect(page).to have_content 'Search 1'
      end.to change { SavedSearch.count }.by(1)
    end
  end

  describe 'Update' do
    before do
      visit "/saved-searches/#{saved_search.id}/edit"
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Edit Saved Search', 'Foobar Search'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Foobar Search'
    end

    it 'shows the form' do
      expect(find_field('Name').value).to eq 'Foobar Search'
    end

    it 'updates an existing saved search' do
      expect do
        fill_in 'Name', with: 'Bazbar Search'

        click_button 'Save'

        expect(page).to have_content 'Bazbar Search'

        saved_search.reload
      end.to change { saved_search.name }.from('Foobar Search').to('Bazbar Search')
    end
  end
end
