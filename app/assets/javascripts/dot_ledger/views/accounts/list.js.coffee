DotLedger.module 'Views.Accounts', ->
  class @List extends Backbone.Marionette.CompositeView
    className: 'panel panel-default'
    template: 'accounts/list'
    getItemView: -> DotLedger.Views.Accounts.ListItem
    itemViewContainer: '.list-group'
    templateHelpers: ->
      totalCash: =>
        balances = @collection.map (account)->
          if account.get('balance') > 0
            account.get('balance')
          else
            0
        _.reduce(balances, ((b,total) -> parseFloat(total) + parseFloat(b)), 0)
      totalDebt: =>
        balances = @collection.map (account)->
          if account.get('balance') < 0
            account.get('balance')
          else
            0
        -_.reduce(balances, ((b,total) -> parseFloat(total) + parseFloat(b)), 0)
