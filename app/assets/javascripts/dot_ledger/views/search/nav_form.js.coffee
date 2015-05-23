DotLedger.module 'Views.Search', ->
  class @NavForm extends Backbone.Marionette.ItemView
    template: 'search/nav_form'

    ui:
      query: 'input[name=query]'

    events:
      'click button.search': 'search'
      'submit form': 'search'

    search: ->
      data = {}
      if @ui.query.val() != ''
        data['query'] = @ui.query.val()

      data['page'] = 1

      @model.clear()
      @model.set(data)

      @trigger 'search', @model

      # FIXME: This is yuck.
      DotLedger.navigate.search(@model.attributes, trigger: true)

      return false
