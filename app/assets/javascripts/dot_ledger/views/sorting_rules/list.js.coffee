DotLedger.module 'Views.SortingRules', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'sorting_rules/list'
    getChildView: -> DotLedger.Views.SortingRules.ListItem
    childViewContainer: 'table tbody'
    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)
