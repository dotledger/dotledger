this.DotLedgerData = {
  account_types: ['Cheque', 'Savings', 'Credit Card', 'Other'],
  category_types: ['Essential', 'Flexible', 'Income', 'Transfer'],
  goal_periods: ['Month', 'Fortnight', 'Week'],
  goal_types: ['Spend', 'Receive'],
  payment_types: ['Spend', 'Receive'],
  payment_periods: ['Day', 'Week', 'Month']
};

this.DotLedger.trigger('options:change', this.DotLedgerData);
