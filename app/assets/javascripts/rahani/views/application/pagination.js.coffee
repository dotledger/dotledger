Rahani.module 'Views.Application', ->
  class @Pagination extends Backbone.Marionette.ItemView

    template: 'application/pagination'

    events:
      'click .next': ->
        @collection.nextPage()

      'click .previous': ->
        @collection.previousPage()

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
