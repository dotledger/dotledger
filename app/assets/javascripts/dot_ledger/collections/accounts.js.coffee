DotLedger.module 'Collections', ->
  class @Accounts extends @Base
    url: '/api/accounts'
    model: DotLedger.Models.Account
