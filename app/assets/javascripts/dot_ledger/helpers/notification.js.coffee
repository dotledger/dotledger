DotLedger.module 'Helpers', ->
  notificationView = (message, class_name)->
    model = new Backbone.Model(message: message)
    new DotLedger.Views.Application.Notification(model: model, className: "alert alert-#{class_name} alert-dismissable")

  @Notification =
    danger: (message)=>
      view = notificationView(message, 'danger')
      @app.notificationsRegion.show(view)
      window.scroll(0, 0)

    success: (message)=>
      view = notificationView(message, 'success')
      @app.notificationsRegion.show(view)
      window.scroll(0, 0)

    info: (message)=>
      view = notificationView(message, 'info')
      @app.notificationsRegion.show(view)
      window.scroll(0, 0)

    warning: (message)=>
      view = notificationView(message, 'warning')
      @app.notificationsRegion.show(view)
      window.scroll(0, 0)

    empty: =>
      @app.notificationsRegion.empty()
