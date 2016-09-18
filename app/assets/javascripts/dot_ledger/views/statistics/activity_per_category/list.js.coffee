DotLedger.module 'Views.Statistics.ActivityPerCategory', ->
  class @List extends Backbone.Marionette.CompositeView
    childViewContainer: '.list-group'
    className: 'panel panel-default'
    template: 'statistics/activity_per_category/list'
    getChildView: -> DotLedger.Views.Statistics.ActivityPerCategory.ListItem

    templateHelpers: ->
      spentAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_spent)
      receivedAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_received)
      netAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_net)