DotLedger.module 'Helpers', ->
  namedParam = /[:\*](\w+)/g

  @Path =
    routesToNavigateHelpers: (routes)->
      helpers = {}
      _.each routes, (funcName, route) ->
        fn = DotLedger.Helpers.Path.routeToPathHelper(route)
        helpers[funcName] = (args = {}, navigateOptions = {})->
          Backbone.history.navigate(fn(args), navigateOptions)
      helpers

    routesToPathHelpers: (routes)->
      helpers = {}
      _.each routes, (funcName, route) ->
        helpers[funcName] = DotLedger.Helpers.Path.routeToPathHelper(route)
      helpers

    routeToPathHelper: (route)->
      (args = {})->
        matched = []
        path = route.replace namedParam, (_, key)->
          if args.hasOwnProperty(key)
            matched.push(key)
            args[key]
          else
            ""

        omitted = new DotLedger.Models.QueryParams(_.omit(args, matched))

        if omitted.isEmpty()
          return "/#{path}"
        else
          return "/#{path}?#{omitted}"
