DotLedger.module 'Views.Payments', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'payments/list_item'
    templateHelpers: ->
      spendAmount: =>
        if @model.get('type') == 'Spend'
          DotLedger.Helpers.Format.money(@model.get('amount'))
      receiveAmount: =>
        if @model.get('type') == 'Receive'
          DotLedger.Helpers.Format.money(@model.get('amount'))
