DotLedger.module 'Regions', ->
  class @Modal extends Backbone.Marionette.Region
    onShow: (view) ->
      view.$el.modal "show"
      #view.$el.attr 'role', 'dialog'
      @listenTo view, "before:close", @closeModal, this

    closeModal: ->
      if @currentView
        @stopListening()
        @currentView.$el.modal "hide"
