DotLedger.module 'Collections', ->
  class @SortingRules extends @Base
    url: '/api/sorting_rules'
    model: DotLedger.Models.SortingRule
