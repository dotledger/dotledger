DotLedger.module 'Views.Statistics.ActivityPerCategory', ->
  class @List extends Backbone.Marionette.CompositeView
    itemViewContainer: '.list-group'
    className: 'panel panel-default'
    template: 'statistics/activity_per_category/list'
    getItemView: -> DotLedger.Views.Statistics.ActivityPerCategory.ListItem
