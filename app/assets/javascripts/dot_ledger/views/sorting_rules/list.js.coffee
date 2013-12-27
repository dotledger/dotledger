DotLedger.module 'Views.SortingRules', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'sorting_rules/list'
    getItemView: -> DotLedger.Views.SortingRules.ListItem
    itemViewContainer: 'table tbody'
    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)
