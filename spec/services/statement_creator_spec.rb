require 'rails_helper'

describe StatementCreator do
  let(:account) { FactoryGirl.create :account }
  let(:file) { File.open("#{fixture_path}/example.ofx") }
  let(:blank_file) { File.open("#{fixture_path}/blank.txt") }

  describe 'valid' do
    let(:statement_creator) { StatementCreator.new(account: account, file: file) }

    it 'should create a statement' do
      expect do
        statement_creator.save
      end.to change(Statement, :count).by(1)
    end

    it 'should create 4 transaction' do
      expect do
        statement_creator.save
      end.to change(Transaction, :count).by(4)
    end

    describe '.statement' do
      before { statement_creator.save }

      it 'should return the statement' do
        expect(statement_creator.statement).to be_an_instance_of Statement
      end

      it 'should set the from_date' do
        expect(statement_creator.statement.from_date).to eq Time.parse('2013-01-05').utc.to_date
      end

      it 'should set the to_date' do
        expect(statement_creator.statement.to_date).to eq Time.parse('2013-01-30').utc.to_date
      end
    end

    describe 'set account balance' do
      context 'latest statement' do
        before do
          FactoryGirl.create :statement,
            to_date: Date.parse('2012-12-01'),
            balance: 10.00,
            account: account
          account.update(balance: 10.00)
        end

        it 'should update the account balance' do
          expect do
            statement_creator.save
          end.to change(account, :balance).from(10.to_d).to(2000.to_d)
        end
      end

      context 'older statement' do
        before do
          FactoryGirl.create :statement,
            to_date: Date.parse('2013-03-01'),
            balance: 10.00,
            account: account
          account.update(balance: 10.00)
        end

        it 'should update the account balance' do
          expect do
            statement_creator.save
          end.to_not change(account, :balance)
        end
      end
    end
  end

  describe 'missing account' do
    let(:statement_creator) { StatementCreator.new(file: file) }

    it 'should have an error on account' do
      expect(statement_creator).to have(1).error_on(:account)
    end
  end

  describe 'missing file' do
    let(:statement_creator) { StatementCreator.new(account: account) }

    it 'should have an error on file' do
      expect(statement_creator).to have(1).error_on(:file)
    end
  end

  describe 'invalid file' do
    let(:statement_creator) { StatementCreator.new(account: account, file: blank_file) }

    it 'should have an error on file' do
      expect(statement_creator).to have(1).error_on(:file)
    end
  end
end
