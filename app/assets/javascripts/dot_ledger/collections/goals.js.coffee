DotLedger.module 'Collections', ->
  class @Goals extends @Base
    url: '/api/goals'
    model: DotLedger.Models.Goal
