if Rails.env.development?

  Account.create! [
    {:name => 'Eftpos', :number => '12-1234-1234567-001', :type => 'Cheque'},
    {:name => 'Savings', :number => '12-1234-1234567-002', :type => 'Savings'},
    {:name => 'Visa', :number => '4111-XXXX-XXXX-1111', :type => 'Credit Card'},
    {:name => 'MasterCard', :number => '5500-XXXX-XXXX-0004', :type => 'Credit Card'}
  ]

  categories = {
    'Flexible' => [
      'Cash Withdrawals',
      'Clothing & Small Purchases',
      'Eating Out',
      'Entertainment & Recreation',
      'General/Misc',
      'Gifts & Donations',
      'Holidays',
      'House Expenses',
      'Personal Care & Fitness'
    ],
    'Essential' => [
      'Bank Charges',
      'Bills & Utilities',
      'Business Expenses',
      'Credit Card',
      'Education',
      'Groceries',
      'Housing',
      'Insurance',
      'Medical & Dental',
      'Motor Vehicles & Transport',
      'Tax'
    ],
    'Income' => [
      'Interest',
      'Other Income & Deposits',
      'Salary & Wages',
      'Tax Credits'
    ]
  }

  categories.each do |type, names|
    names.each do |name|
      Category.create!(:type => type, :name => name)
    end
  end

end
