DotLedger.module 'Views.Search', ->
  class @Summary extends Backbone.Marionette.ItemView
    template: 'search/summary'

    onRender: ->
      @collection.on 'sync', @render

    templateHelpers: ->
      totalCount: =>
        @collection.pagination && @collection.pagination.total_items
      totalSpent: =>
        @collection.metadata && @collection.metadata.total_spent
      totalReceived: =>
        @collection.metadata && @collection.metadata.total_received
