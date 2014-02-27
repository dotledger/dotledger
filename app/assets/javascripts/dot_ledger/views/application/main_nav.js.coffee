DotLedger.module 'Views.Application', ->
  class @MainNav extends Backbone.Marionette.ItemView
    template: 'application/main_nav'
    className: 'navbar navbar-default navbar-fixed-top'

    ui:
      nav_search: '#nav-search'

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

    onRender: ->
      # FIXME: This is yuck.
      searchModel = new Backbone.Model()
      searchForm = new DotLedger.Views.Search.NavForm(model: searchModel)
      @ui.nav_search.html(searchForm.render().el)
