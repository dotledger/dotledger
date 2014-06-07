class Balance
  include ActiveModel::SerializerSupport
  include Virtus.model

  attribute :date
  attribute :balance
  attribute :account_id

  def active_model_serializer
    BalanceSerializer
  end
end
