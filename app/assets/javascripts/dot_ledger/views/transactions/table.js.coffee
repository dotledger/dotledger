DotLedger.module 'Views.Transactions', ->
  class @Table extends Backbone.Marionette.CompositeView
    template: 'transactions/table'
    itemViewContainer: 'tbody'
    getItemView: -> DotLedger.Views.Transactions.TableRow
    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)
