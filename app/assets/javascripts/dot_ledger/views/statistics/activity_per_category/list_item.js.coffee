DotLedger.module 'Views.Statistics.ActivityPerCategory', ->
  class @ListItem extends Backbone.Marionette.ItemView
    template: 'statistics/activity_per_category/list_item'

    className: 'list-group-item'

    events:
      'click strong.name a': 'search'

    search: ->
      params =
        category_id: @model.get('id')
        date_from: @model.collection.metadata.date_from
        date_to: @model.collection.metadata.date_to
        page: 1

      DotLedger.navigate.search(params, trigger: true)

      false

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
