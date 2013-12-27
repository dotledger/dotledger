DotLedger.module 'Views.Payments', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'payments/list_item'
    templateHelpers: ->
      spendAmount: =>
        if @model.get('type') == 'Spend'
          accounting.formatMoney(@model.get('amount'))
      receiveAmount: =>
        if @model.get('type') == 'Receive'
          accounting.formatMoney(@model.get('amount'))
