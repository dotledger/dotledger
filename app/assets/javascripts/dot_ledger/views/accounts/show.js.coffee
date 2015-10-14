DotLedger.module 'Views.Accounts', ->
  class @Show extends Backbone.Marionette.LayoutView
    initialize: (options)->
      @params = options.params

    template: 'accounts/show'

    regions:
      transactions: '#transactions'
      graph: '#graph'

    events:
      'click a[data-tab]': 'clickTab'

    setActiveTab: ->
      @$el.find("a[data-tab]").parent().removeClass('active')
      @$el.find("a[data-tab='#{@params.get('tab')}']").parent().addClass('active')

    clickTab: (event)->
      event.preventDefault()
      @params.set(tab: $(event.target).data('tab'))
      @setActiveTab()

    onRender: ->
      @setActiveTab()
