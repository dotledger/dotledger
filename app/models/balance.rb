class Balance
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :date, :balance, :account_id

  def active_model_serializer
    BalanceSerializer
  end
end
