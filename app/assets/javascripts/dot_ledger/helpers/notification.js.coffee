DotLedger.module 'Helpers', ->
  notificationView = (message, class_name)->
    model = new Backbone.Model(message: message)
    new DotLedger.Views.Application.Notification(model: model, className: "alert alert-#{class_name} alert-dismissable")

  @Notification =
    danger: (message)=>
      view = notificationView(message, 'danger')
      @app.notificationsRegion.show(view)

    success: (message)=>
      view = notificationView(message, 'success')
      @app.notificationsRegion.show(view)

    info: (message)=>
      view = notificationView(message, 'info')
      @app.notificationsRegion.show(view)

    warning: (message)=>
      view = notificationView(message, 'warning')
      @app.notificationsRegion.show(view)

    empty: =>
      @app.notificationsRegion.empty()
