DotLedger.addInitializer (options)->
  @router = new DotLedger.Routers.App()
  Backbone.history.start(pushState: true)
