require 'rails_helper'

feature 'Goals', truncate: true, js: true do
  include ActionView::Helpers::NumberHelper

  describe 'Index' do
    let!(:essential_category) do
      FactoryBot.create :category, type: 'Essential', name: 'Groceries'
    end

    let!(:flexible_category) do
      FactoryBot.create :category, type: 'Flexible', name: 'Eating Out'
    end

    background do
      essential_category.goal.update_attributes(amount: 125, period: 'Week')
      flexible_category.goal.update_attributes(amount: 100)
    end

    before do
      visit '/goals'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Goals'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Goals'
    end

    it 'shows the category type headings' do
      expect(page).to have_content 'Essential'
      expect(page).to have_content 'Flexible'
    end

    it 'shows the category names' do
      expect(page).to have_content 'Groceries'
      expect(page).to have_content 'Eating Out'
    end

    it 'shows the goal amounts' do
      expect(page).to have_content number_to_currency(125 * Goal::WEEK_MULTIPLIER)
      expect(page).to have_content number_to_currency(100)
    end

    it 'shows the save button' do
      expect(page).to have_button 'Save'
    end
  end
end
