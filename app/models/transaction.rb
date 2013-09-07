class Transaction < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :account

  belongs_to :statement

  has_one :sorted_transaction

  validates :amount, :presence => true

  validates :fit_id, :presence => true

  validates :account, :presence => true

  validates :search, :presence => true

  before_validation :set_search
  
  scope :unsorted, proc {
    includes(:sorted_transaction).where(:sorted_transactions => {:id => nil})
  }

  scope :sorted, proc {
    includes(:sorted_transaction).where.not(:sorted_transactions => {:id => nil}).references(:sorted_transactions)
  }

  scope :for_review, proc {
    includes(:sorted_transaction).where(:sorted_transactions => {:review => true})
  }

  scope :not_for_review, proc {
    includes(:sorted_transaction).where(:sorted_transactions => {:review => false})
  }

  private

  def set_search
    self.search = "#{self.name} #{self.memo}".strip.titleize.gsub(/\s+/, ' ')
  end
end
