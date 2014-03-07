DotLedger.module 'Views.Application', ->
  class @Pagination extends Backbone.Marionette.ItemView

    template: 'application/pagination'

    events:
      'click .next': ->
        if @collection.pagination && @collection.pagination.next_page?
          @collection.nextPage()
        false

      'click .previous': ->
        if @collection.pagination && @collection.pagination.previous_page?
          @collection.previousPage()
        false

    initialize: ->
      @collection.on 'reset sync', =>
        @render()
      this

    templateHelpers: ->
      pagination: @collection.pagination

      disablePrevious: =>
        if @collection.pagination && !@collection.pagination.previous_page?
          'disabled'

      disableNext: =>
        if @collection.pagination && !@collection.pagination.next_page?
          'disabled'
