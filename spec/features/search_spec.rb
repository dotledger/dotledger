require 'rails_helper'

feature "Search", :truncate => true, :js => true do
  background do
    FactoryGirl.create :transaction, :name => 'Foobar Something'
    FactoryGirl.create :transaction, :name => 'Another Foobar'
    FactoryGirl.create :transaction, :name => 'Blah'
  end

  describe "results" do
    before do
      visit "/search/~(query~'Foobar)/page-1"
    end

    it "fills the query field" do
      expect(find_field('Search for').value).to eq 'Foobar'
    end

    it "returns search results" do
      expect(page).to have_content 'Foobar Something'
      expect(page).to have_content 'Another Foobar'
      expect(page).to_not have_content 'Blah'
    end
  end
end
