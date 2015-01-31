DotLedger.addInitializer (options)->
  @router = new DotLedger.Routers.App()
  @router.on 'route', ->
    DotLedger.Helpers.Notification.empty()
  Backbone.history.start(pushState: true)
