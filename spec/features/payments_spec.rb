require 'rails_helper'

feature 'Payments', truncate: true, js: true do
  include ActionView::Helpers::NumberHelper

  let(:date) { Time.now + 4.days }

  let!(:category) do
    FactoryGirl.create :category, type: 'Income', name: 'Salary & Wages'
  end

  let!(:payment) do
    FactoryGirl.create :payment,
                       category: category,
                       name: 'Foobar Wages',
                       amount: 5000,
                       type: 'Receive',
                       schedule: IceCube::Schedule.new(date)
  end

  describe 'Index' do
    before do
      visit '/payments'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Payments'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Payments'
    end

    it 'shows the payment date' do
      expect(page).to have_content date.strftime('%B %e, %Y')
    end

    it 'shows the payment name' do
      expect(page).to have_content 'Foobar Wages'
    end

    it 'shows the payment amount' do
      expect(page).to have_content number_to_currency(5000)
    end
  end

  describe 'Create' do
    let!(:category) { FactoryGirl.create :category }

    before do
      visit '/payments/new'
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'New Payment'
    end

    it 'shows the heading' do
      expect(page).to have_content 'New Payment'
    end

    it 'shows the form' do
      expect(page).to have_field 'Name'
      expect(page).to have_field 'Type'
      expect(page).to have_field 'Amount'
      expect(page).to have_field 'Category'
      expect(page).to have_field 'Date'
      expect(page).to have_button 'Save'
      expect(page).to have_link 'Cancel', href: '/payments'
    end

    it 'creates a new payment' do
      expect do
        fill_in 'Name', with: 'Some Payment'
        select 'Spend', from: 'Type'
        select category.name, from: 'Category'
        fill_in 'Amount', with: 100
        fill_in 'Date', with: date.strftime('%Y-%m-%d')

        # FIXME: the datepicker seems to be overlapping the save button
        find_button('Save').trigger('click')

        expect(page).to have_content 'Some Payment'
      end.to change { Payment.count }.by(1)
    end
  end

  describe 'Update' do
    before do
      visit "/payments/#{payment.id}/edit"
    end

    it 'sets the correct page title' do
      expect_page_title_to_be 'Edit Payment', 'Foobar Wages'
    end

    it 'shows the heading' do
      expect(page).to have_content 'Foobar Wages'
    end

    it 'shows the form' do
      expect(find_field('Name').value).to eq 'Foobar Wages'
      expect(find_field('Type').value).to eq 'Receive'
      expect(find_field('Amount').value).to eq '5000.0'
      expect(find_field('Category').value).to eq category.id.to_s
      expect(find_field('Date').value).to eq date.strftime('%Y-%m-%d')
    end

    it 'updates an existing payment' do
      expect do
        fill_in 'Name', with: 'Foobar Salary'

        click_button 'Save'

        expect(page).to have_content 'Foobar Salary'

        payment.reload
      end.to change { payment.name }.from('Foobar Wages').to('Foobar Salary')
    end
  end
end
