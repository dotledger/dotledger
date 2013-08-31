require 'spec_helper'

describe StatementCreator do
  let(:account) { FactoryGirl.create :account }
  let(:file) { File.open("#{fixture_path}/example.ofx") }
  let(:statement_creator) { StatementCreator.new(account, file) }

  it "should create a statement" do
    expect {
      statement_creator.call
    }.to change(Statement, :count).by(1)
  end

  it "should create 4 transaction" do
    expect {
      statement_creator.call
    }.to change(Transaction, :count).by(4)
  end

  it "should return the statement" do
    expect(statement_creator.call).to be_an_instance_of Statement
  end
end
