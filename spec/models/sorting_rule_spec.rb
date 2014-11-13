require 'rails_helper'

describe SortingRule do
  it { should have_db_column(:contains).of_type(:string).with_options(null: false) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:name).of_type(:string).with_options(default: nil) }

  it { should have_db_column(:review).of_type(:boolean).with_options(default: false, null: false) }

  it { should have_db_column(:tag_ids).of_type(:integer).with_options(array: true) }

  it { should have_db_index(:contains).unique(:true) }

  it { should validate_presence_of :contains }

  it { should validate_presence_of :category }

  it { should belong_to :category }

  describe 'tags' do
    let!(:tag1) { FactoryGirl.create :tag, name: 'First Tag' }

    let!(:tag2) { FactoryGirl.create :tag , name: 'Second Tag' }

    describe '.tags' do
      subject { FactoryGirl.build :sorting_rule, tag_ids: [tag1.id, tag2.id] }

      specify do
        expect(subject.tags).to eq [tag1, tag2]
      end
    end

    describe '.tags=' do
      subject { FactoryGirl.build :sorting_rule, tag_ids: [] }

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
  end
end
