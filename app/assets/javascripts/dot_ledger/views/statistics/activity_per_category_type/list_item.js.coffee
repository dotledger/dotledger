DotLedger.module 'Views.Statistics.ActivityPerCategoryType', ->
  class @ListItem extends Backbone.Marionette.ItemView
    template: 'statistics/activity_per_category_type/list_item'

    className: 'list-group-item'