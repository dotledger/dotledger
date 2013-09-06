class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :fit_id, :memo, :name, :payee, :posted_at,
    :ref_number, :type, :account_id, :statement_id, :search
end
