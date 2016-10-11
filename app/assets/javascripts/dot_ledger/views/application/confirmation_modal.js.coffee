DotLedger.module 'Views.Application', ->
  class @ConfirmationModal extends Backbone.Marionette.ItemView
    template: 'application/confirmation_modal'
    className: 'modal'

    ui:
      confirm: '.confirm'
      close: 'button.close'
      cancel: '.cancel'

    events:
      'click @ui.confirm': 'confirm'
      'click @ui.close': 'close'
      'click @ui.cancel': 'close'

    confirm: ->
      @trigger('confirm')
      @destroy()

    close: ->
      @destroy()

    templateHelpers: ->
      title: =>
        @options.title || 'Are you sure?'
      body: =>
        @options.body  || 'Are you sure you want to continue?'
      confirm: =>
        @options.confirm || 'Confirm'
      cancel: =>
        @options.cancel || 'Cancel'