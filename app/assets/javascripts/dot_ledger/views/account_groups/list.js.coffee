DotLedger.module 'Views.AccountGroups', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'account_groups/list'
    getChildView: -> DotLedger.Views.AccountGroups.ListItem
    childViewContainer: 'table tbody'