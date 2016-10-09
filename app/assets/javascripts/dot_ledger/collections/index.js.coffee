#= require_self
#= require ./account_groups
#= require ./accounts
#= require ./balances
#= require ./categories
#= require ./goals
#= require ./index
#= require ./payments
#= require ./projected_balances
#= require ./sorting_rules
#= require ./statements
#= require ./tags
#= require ./transactions

DotLedger.module 'Collections', ->
  class @Base extends Backbone.Collection
    pagination: {}

    metadata: {}

    parse: (response, options)->
      @_fetch_options_data = options.data || {}
      @pagination = JSON.parse options.xhr.getResponseHeader('X-Pagination')
      @metadata = JSON.parse options.xhr.getResponseHeader('X-Metadata')
      response

    nextPage: ->
      @trigger 'page:change', @pagination.next_page

      if @pagination && @pagination.next_page?
        data = _.extend(
          @_fetch_options_data,
          page: @pagination.next_page
        )

        @fetch
          reset: true
          data: data

    previousPage: ->
      @trigger 'page:change', @pagination.previous_page

      if @pagination && @pagination.previous_page?
        data = _.extend(
          @_fetch_options_data,
          page: @pagination.previous_page
        )

        @fetch
          reset: true
          data: data
