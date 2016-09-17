DotLedger.module 'Views.AccountGroups', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'account_groups/list_item'
