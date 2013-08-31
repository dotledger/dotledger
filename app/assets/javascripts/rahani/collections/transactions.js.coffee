Rahani.module 'Collections', ->
  class @Transactions extends @Base
    url: '/api/transactions'
    model: Rahani.Models.Transaction
