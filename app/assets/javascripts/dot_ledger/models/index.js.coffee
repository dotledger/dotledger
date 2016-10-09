#= require_self
#= require ./account
#= require ./account_group
#= require ./balance
#= require ./category
#= require ./goal
#= require ./payment
#= require ./query_params
#= require ./sorted_transaction
#= require ./sorting_rule
#= require ./statement
#= require ./tag
#= require ./transaction

DotLedger.module 'Models', ->
  class @Base extends Backbone.Model
    constructor: ->
      Backbone.Model::constructor.apply(this, _.toArray(arguments))

      @listenTo(this, 'error', @serverSideErrors)

    serverSideErrors: (model, resp, options = {}) ->
      if resp.status == 422
        errors = JSON.parse(resp.responseText).errors
        model.validationError = errors
        model.trigger "invalid", model, errors, _.extend(options,
          validationError: errors
        )