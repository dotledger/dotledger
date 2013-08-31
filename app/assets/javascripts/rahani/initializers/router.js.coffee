Rahani.addInitializer (options)->
  @router = new Rahani.Routers.App()
  Backbone.history.start(pushState: true)
