Rahani.module 'Views.Accounts', ->
  class @Show extends Backbone.Marionette.Layout
    initialize: (options)->
      @tab = options.tab
    template: 'accounts/show'
    regions:
      transactions: '#transactions'
    onRender: ->
      @$el.find("a[data-tab-id='#{@tab}-transactions']").parent().addClass('active')
