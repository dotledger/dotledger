DotLedger.module 'Views.Application', ->
  class @MainNav extends Backbone.Marionette.ItemView
    template: 'application/main_nav'
    className: 'navbar navbar-default navbar-fixed-top'
    initialize: ->
      @active = 'root'
      Backbone.history.on 'route', (app, route, args)=>
        @active = route
        @render()

    templateHelpers: ->
      activeClass: (routes...)=>
        if _.include(routes, @active)
          'active'

      accounts: =>
        @options.accounts
