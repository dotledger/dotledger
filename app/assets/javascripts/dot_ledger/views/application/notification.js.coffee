DotLedger.module 'Views.Application', ->
  class @Notification extends Backbone.Marionette.LayoutView
    template: 'application/notification'

    ui:
      close: 'button.close'

    events:
      'click button.close': 'remove'
