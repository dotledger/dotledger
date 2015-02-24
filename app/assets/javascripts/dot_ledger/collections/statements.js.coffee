DotLedger.module 'Collections', ->
  class @Statements extends @Base
    url: '/api/statements'
    model: DotLedger.Models.Statement
