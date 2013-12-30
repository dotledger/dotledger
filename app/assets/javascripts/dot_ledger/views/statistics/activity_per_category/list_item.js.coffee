DotLedger.module 'Views.Statistics.ActivityPerCategory', ->
  class @ListItem extends Backbone.Marionette.ItemView
    template: 'statistics/activity_per_category/list_item'
    className: 'list-group-item'
    templateHelpers: ->
      progressWidth: =>
        if @model.get('goal') * 1 > 0
          (@model.get('spent') * 1 / @model.get('goal') * 1) * 100
        else
          100 if @templateHelpers().overGoal()

      overGoal: =>
        @model.get('spent') * 1 > @model.get('goal') * 1

      progressClass: =>
        if @templateHelpers().overGoal()
          'progress-bar-danger'
        else
          'progress-bar-success'
