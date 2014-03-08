DotLedger.module 'Collections', ->
  class @Tags extends @Base
    url: '/api/tags'
    model: DotLedger.Models.Tag
