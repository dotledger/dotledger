require 'rails_helper'

describe SavedSearch do
  it { should have_db_column(:account_id).of_type(:integer) }

  it { should have_db_column(:category_id).of_type(:integer) }

  it { should have_db_column(:tag_ids).of_type(:integer).with_options(array: true) }

  it { should have_db_column(:review).of_type(:string).with_options(null: false, default: "") }

  it { should have_db_column(:name).of_type(:string).with_options(null: false) }

  it { should have_db_column(:query).of_type(:string) }

  it { should have_db_column(:date_from).of_type(:datetime) }

  it { should have_db_column(:date_to).of_type(:datetime) }

  it { should have_db_column(:period_from).of_type(:string) }

  it { should have_db_column(:period_to).of_type(:string) }

  it { should validate_inclusion_of(:review).in_array(['true', 'false']).allow_blank }

  it { should validate_inclusion_of(:period_from).in_array(['Beginning of year', 'Beginning of quarter', 'Beginning of month', 'Beginning of week']).allow_blank }

  it { should validate_inclusion_of(:period_to).in_array(['End of year', 'End of quarter', 'End of month', 'End of week', 'Today']).allow_blank }

  it { should validate_presence_of :name }

  it { should belong_to :account }

  it { should belong_to :category }

  describe 'tags' do
    let!(:tag1) { FactoryBot.create :tag, name: 'First Tag' }

    let!(:tag2) { FactoryBot.create :tag, name: 'Second Tag' }

    describe '.tags' do
      subject { FactoryBot.build :saved_search, tag_ids: [tag1.id, tag2.id] }

      specify do
        expect(subject.tags).to eq [tag1, tag2]
      end
    end

    describe '.tags=' do
      subject { FactoryBot.build :saved_search, tag_ids: [] }

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
          expect do
            subject.tags = { foo: 'bar' }
          end.to raise_error StandardError, 'unknown tag list'
        end
      end
    end

    describe '.tag_list' do
      subject { FactoryBot.build :saved_search, tag_ids: [tag1.id, tag2.id] }

      specify do
        expect(subject.tag_list).to eq [tag1.name, tag2.name]
      end
    end

    describe '.tag_list=' do
      subject { FactoryBot.build :saved_search, tag_ids: [] }

      before do
        subject.tag_list = [tag1.name, tag2.name]
      end

      specify do
        expect(subject.tag_ids).to eq [tag1.id, tag2.id]
      end
    end
  end
end
