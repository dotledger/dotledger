DotLedger.module 'Views.Accounts', ->
  class @List extends Backbone.Marionette.CompositeView
    className: 'panel panel-default'
    template: 'accounts/list'
    getChildView: -> DotLedger.Views.Accounts.ListItem
    attachHtml: (collectionView, childView, index)->
      list_id = "account_group_#{childView.model.get('account_group_id')}"
      collectionView.$("div##{list_id}").append(childView.el)
    templateHelpers: ->
      accountGroups: =>
        accountGroups = {}
        @collection.forEach (account)=>
          accountGroups[account.get('account_group_id')] = account.get('account_group_name')
        _.map accountGroups, (name, id)=>
          net = @collection.
            chain().
            select((account)-> account.get('account_group_id') == id).
            map((account)-> account.get('balance')).
            reduce(((total, balance)->  total + parseFloat(balance)), 0.0).
            value()
          label: name
          id: "account_group_#{id}"
          net: net
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
