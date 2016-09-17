DotLedger.module 'Collections', ->
  class @AccountGroups extends @Base
    url: '/api/account_groups'
    model: DotLedger.Models.AccountGroup
