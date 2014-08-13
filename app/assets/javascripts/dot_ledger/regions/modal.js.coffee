DotLedger.module 'Regions', ->
  class @Modal extends Backbone.Marionette.Region
    onShow: (view) ->
      view.$el.modal "show"
      #view.$el.attr 'role', 'dialog'
      @listenTo view, "before:destroy", @closeModal, this

    closeModal: ->
      if @currentView
        @stopListening()
        @currentView.$el.modal "hide"
