DotLedger.module 'Collections', ->
  class @Categories extends @Base
    url: '/api/categories'
    model: DotLedger.Models.Category
