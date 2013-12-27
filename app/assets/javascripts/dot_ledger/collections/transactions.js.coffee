DotLedger.module 'Collections', ->
  class @Transactions extends @Base
    url: '/api/transactions'
    model: DotLedger.Models.Transaction
