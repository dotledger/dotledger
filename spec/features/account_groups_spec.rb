require 'rails_helper'

feature 'AccountGroups', truncate: true, js: true do
  include ActionView::Helpers::NumberHelper

  let!(:account_group) do
    FactoryBot.create :account_group, name: 'Foobar Group'
  end

  describe 'Index' do
    before do
      visit '/account-groups'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Account Groups'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Account Groups'
    end

    it 'shows the account_group name' do
      expect(page).to have_content 'Foobar Group'
    end
  end

  describe 'Create' do
    before do
      visit '/account-groups/new'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'New Account Group'
    end

    it 'shows the heading' do
      expect(page).to have_content 'New Account Group'
    end

    it 'shows the form' do
      expect(page).to have_field 'Name'
      expect(page).to have_button 'Save'
      expect(page).to have_link 'Cancel', href: '/account-groups'
    end

    it 'creates a new account group' do
      expect do
        fill_in 'Name', with: 'Group 1'

        click_button 'Save'

        expect(page).to have_content 'Group 1'
      end.to change { AccountGroup.count }.by(1)
    end
  end

  describe 'Update' do
    before do
      visit "/account-groups/#{account_group.id}/edit"
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Edit Account Group', 'Foobar Group'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Foobar Group'
    end

    it 'shows the form' do
      expect(find_field('Name').value).to eq 'Foobar Group'
    end

    it 'updates an existing account group' do
      expect do
        fill_in 'Name', with: 'Bazbar Group'

        click_button 'Save'

        expect(page).to have_content 'Bazbar Group'

        account_group.reload
      end.to change { account_group.name }.from('Foobar Group').to('Bazbar Group')
    end
  end
end
