class AddStatementIdToTransactions < ActiveRecord::Migration
  def change
    add_reference :transactions, :statement, :index => true
  end
end
