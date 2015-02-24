DotLedger.module 'Views.Accounts', ->
  class @Show extends Backbone.Marionette.LayoutView
    initialize: (options)->
      @tab = options.tab

    template: 'accounts/show'

    regions:
      transactions: '#transactions'
      graph: '#graph'

    onRender: ->
      @$el.find("a[data-tab-id='#{@tab}-transactions']").parent().addClass('active')
