@DotLedgerData =
  account_types: ['Cheque', 'Savings', 'Credit Card', 'Other']
  category_types: ['Essential', 'Flexible', 'Income', 'Transfer']
  goal_periods: ['Month', 'Fortnight', 'Week']
  goal_types: ['Spend', 'Receive']
  payment_types: ['Spend', 'Receive']
  payment_periods: ['Day', 'Week', 'Month']

@DotLedger.trigger 'options:change', @DotLedgerData
