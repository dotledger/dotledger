DotLedger.module 'Views.Application', ->
  class @Notification extends Backbone.Marionette.Layout
    template: 'application/notification'

    ui:
      close: 'button.close'

    events:
      'click button.close': 'remove'
