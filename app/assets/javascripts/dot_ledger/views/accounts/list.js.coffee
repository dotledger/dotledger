DotLedger.module 'Views.Accounts', ->
  class @List extends Backbone.Marionette.CompositeView
    className: 'panel panel-default'
    template: 'accounts/list'
    getChildView: -> DotLedger.Views.Accounts.ListItem
    attachHtml: (collectionView, childView, index)->
      list_id =  "account-group-#{s.underscored(childView.model.get('account_group_name'))}"
      collectionView.$("div##{list_id}").append(childView.el)
    templateHelpers: ->
      accountGroups: =>
        accountGroups = _.uniq(@collection.pluck('account_group_name'))
        _.map accountGroups, (name)->
          label: name
          id: "account-group-#{s.underscored(name)}"
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
