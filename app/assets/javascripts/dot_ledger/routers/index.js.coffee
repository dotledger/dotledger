#= require_self
#= require ./app

DotLedger.module 'Routers', ->
  class @Base extends Backbone.Marionette.AppRouter
    execute: (callback, args, name) ->
      params = _.parseQueryString(args.pop())

      @QueryParams = new DotLedger.Models.QueryParams(params)

      args.push(params)
      callback.apply(this, args) if callback?