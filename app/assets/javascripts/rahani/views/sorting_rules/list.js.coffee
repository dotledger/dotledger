Rahani.module 'Views.SortingRules', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'sorting_rules/list'
    getItemView: -> Rahani.Views.SortingRules.ListItem
    itemViewContainer: 'table tbody'
    initialize: ->
      Rahani.Helpers.pagination(this, @collection)
