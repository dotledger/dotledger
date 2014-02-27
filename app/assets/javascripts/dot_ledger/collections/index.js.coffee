#= require_self
#= require_tree .

DotLedger.module 'Collections', ->
  class @Base extends Backbone.Collection
    parse: (response, options)->
      @_fetch_options_data = options.data || {};
      @pagination = JSON.parse options.xhr.getResponseHeader('X-Pagination')
      @metadata = JSON.parse options.xhr.getResponseHeader('X-Metadata')
      response

    nextPage: ->
      if @pagination && @pagination.next_page?
        data = _.extend(
          @_fetch_options_data,
          page: @pagination.next_page
        )

        @fetch
          reset: true
          data: data
    
    previousPage: ->
      if @pagination && @pagination.previous_page?
        data = _.extend(
          @_fetch_options_data,
          page: @pagination.previous_page
        )

        @fetch
          reset: true
          data: data
