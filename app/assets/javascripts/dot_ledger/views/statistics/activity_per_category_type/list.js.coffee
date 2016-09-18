DotLedger.module 'Views.Statistics.ActivityPerCategoryType', ->
  class @List extends Backbone.Marionette.CompositeView
    childViewContainer: '.list-group'
    className: 'panel panel-default'
    template: 'statistics/activity_per_category_type/list'
    getChildView: -> DotLedger.Views.Statistics.ActivityPerCategoryType.ListItem

    ui:
      pieGraph: '#activity-per-category-type-pie'

    templateHelpers: ->
      spentAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_spent)
      receivedAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_received)
      netAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_net)

    pieGraphData: ->
      @collection.map (activity) ->
         {
           label: activity.get('type')
           data: Math.abs(activity.get('net'))
         }

    pieGraphOptions: ->
      series: {
          pie: {
              show: true
          }
      },
      legend: {
          show: false
      }

    renderPieGraph: ->
      if @isRendered
        $.plot(@ui.pieGraph, @pieGraphData(), @pieGraphOptions())

    onRender: ->
      @collection.on 'sync', =>
        @renderPieGraph()
      _.defer(=> @renderPieGraph())
