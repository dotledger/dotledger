require 'rails_helper'

describe SortedTransaction do

  it { should have_db_column(:account_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:transaction_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:tag_ids).of_type(:integer).with_options(array: true) }

  it { should have_db_column(:review).of_type(:boolean).with_options(default: false, null: false) }

  it { should have_db_column(:name).of_type(:string) }

  it { should validate_presence_of :account }

  it { should validate_presence_of :account_transaction }

  it { should validate_presence_of :name }

  it { should validate_presence_of :category }

  it { should belong_to :account }

  it { should belong_to :account_transaction }

  describe 'tags' do
    let!(:tag1) { FactoryGirl.create :tag, name: 'First Tag' }

    let!(:tag2) { FactoryGirl.create :tag , name: 'Second Tag'}

    describe '.tags' do
      subject { FactoryGirl.build :sorted_transaction, tag_ids: [tag1.id, tag2.id] }

      specify do
        expect(subject.tags).to eq [tag1, tag2]
      end
    end

    describe '.tags=' do
      subject { FactoryGirl.build :sorted_transaction, tag_ids: [] }

      context 'a list of tag models' do
        before do
          subject.tags = [tag1, tag2]
        end

        specify do
          expect(subject.tag_ids).to eq [tag1.id, tag2.id]
        end
      end

      context 'a string of tag names' do
        before do
          subject.tags = 'First Tag, Second Tag'
        end

        specify do
          expect(subject.tag_ids).to eq [tag1.id, tag2.id]
        end
      end

      context 'an unexpected type' do
        specify do
          expect {
            subject.tags = {foo: 'bar'}
          }.to raise_error StandardError, 'unknown tag list'
        end
      end
    end
  end
end
