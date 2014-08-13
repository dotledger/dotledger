DotLedger.module 'Views.Transactions', ->
  class @Table extends Backbone.Marionette.CompositeView
    template: 'transactions/table'
    childViewContainer: 'tbody'
    getChildView: -> DotLedger.Views.Transactions.TableRow
    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)
