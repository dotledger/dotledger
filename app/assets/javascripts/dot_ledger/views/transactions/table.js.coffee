DotLedger.module 'Views.Transactions', ->
  class @Table extends Backbone.Marionette.CompositeView
    template: 'transactions/table'
    childViewContainer: 'tbody'
    getChildView: -> DotLedger.Views.Transactions.TableRow
    childViewOptions: (model, index)->
      {
        showAccountName: @options.showAccountName
        model:model
      }
    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)
    templateHelpers: ->
      showAccountName: =>
        !!@options.showAccountName
