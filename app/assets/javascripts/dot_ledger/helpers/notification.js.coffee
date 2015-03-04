DotLedger.module 'Helpers', ->
  notificationView = (message, class_name)->
    model = new Backbone.Model(message: message)
    new DotLedger.Views.Application.Notification(model: model, className: "alert alert-#{class_name} alert-dismissable")

  @Notification =
    levels: ['danger', 'success', 'info', 'warning']
    empty: =>
      @app.notificationsRegion.empty()

  for level in @Notification.levels then do (level)=>
    @Notification[level] = (message)=>
      view = notificationView(message, level)
      @app.notificationsRegion.show(view)
      window.scroll(0, 0)
