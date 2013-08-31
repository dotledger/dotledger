require 'spec_helper'

describe StatementCreator do
  let(:account) { FactoryGirl.create :account }
  let(:file) { File.open("#{fixture_path}/example.ofx") }
  let(:blank_file) { File.open("#{fixture_path}/blank.txt") }

  describe "valid" do
    let(:statement_creator) { StatementCreator.new(:account => account, :file => file) }

    it "should create a statement" do
      expect {
        statement_creator.save
      }.to change(Statement, :count).by(1)
    end

    it "should create 4 transaction" do
      expect {
        statement_creator.save
      }.to change(Transaction, :count).by(4)
    end

    describe ".statement" do
      it "should return the statement" do
        statement_creator.save
        expect(statement_creator.statement).to be_an_instance_of Statement
      end
    end
  end

  describe "missing account" do
    let(:statement_creator) { StatementCreator.new(:file => file) }

    it "should have an error on account" do
      expect(statement_creator).to have(1).error_on(:account)
    end
  end

  describe "missing file" do
    let(:statement_creator) { StatementCreator.new(:account => account) }

    it "should have an error on file" do
      expect(statement_creator).to have(1).error_on(:file)
    end
  end

  describe "invalid file" do
    let(:statement_creator) { StatementCreator.new(:account => account, :file => blank_file) }

    it "should have an error on file" do
      expect(statement_creator).to have(1).error_on(:file)
    end
  end
end
