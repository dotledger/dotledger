DotLedger.module 'Models', ->
  class @QueryParams extends Backbone.Model
    toString: ->
      $.param(@attributes).replace(/%5B%5D/g, '')
