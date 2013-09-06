Rahani.module 'Views.Transactions', ->
  class @Table extends Backbone.Marionette.CompositeView
    template: 'transactions/table'
    itemViewContainer: 'tbody'
    getItemView: -> Rahani.Views.Transactions.TableRow
    initialize: ->
      Rahani.Helpers.pagination(this, @collection)
