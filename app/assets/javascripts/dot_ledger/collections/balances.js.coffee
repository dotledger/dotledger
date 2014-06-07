DotLedger.module 'Collections', ->
  class @Balances extends @Base
    url: '/api/balances'
    model: DotLedger.Models.Balance
