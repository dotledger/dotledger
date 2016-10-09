DotLedger.module 'Collections', ->
  class @ProjectedBalances extends @Base
    url: '/api/balances/projected'
    model: DotLedger.Models.Balance
