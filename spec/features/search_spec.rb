require 'rails_helper'

feature 'Search', truncate: true, js: true do
  background do
    FactoryGirl.create :transaction, name: 'Foobar Something'
    FactoryGirl.create :transaction, name: 'Another Foobar'
    FactoryGirl.create :transaction, name: 'Blah'
  end

  describe 'results' do
    context 'with query' do
      before do
        visit "/search?query=Foobar"
      end

      it 'sets the correct page title' do
        expect_page_title_to_be 'Search', 'Foobar'
      end

      it 'fills the query field' do
        expect(find_field('Search for').value).to eq 'Foobar'
      end

      it 'returns search results' do
        expect(page).to have_content 'Foobar Something'
        expect(page).to have_content 'Another Foobar'
        expect(page).to_not have_content 'Blah'
      end

      context 'with new query' do
        it 'sets the new page title' do
          expect_page_title_to_be 'Search', 'Foobar'
          fill_in 'Search for', with: 'Bazbar'
          click_on 'Search'
          expect_page_title_to_be 'Search', 'Bazbar'
        end
      end
    end

    context 'without query' do
      before do
        visit '/search'
      end

      it 'sets the correct page title' do
        expect_page_title_to_be 'Search'
      end

      it 'leaves the query field blank' do
        expect(find_field('Search for').value).to eq ''
      end

      it 'returns search results' do
        expect(page).to have_content 'Foobar Something'
        expect(page).to have_content 'Another Foobar'
        expect(page).to have_content 'Blah'
      end

      context 'with new query' do
        it 'sets the new page title' do
          expect_page_title_to_be 'Search'
          fill_in 'Search for', with: 'Bazbar'
          click_on 'Search'
          expect_page_title_to_be 'Search', 'Bazbar'
        end
      end
    end
  end
end
