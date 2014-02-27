DotLedger.module 'Views.Search', ->
  class @NavForm extends Backbone.Marionette.ItemView
    template: 'search/nav_form'

    ui:
      query: 'input[name=query]'

    events:
      'click button.search': 'search'
      'submit form': 'search'

    search: ->
      if @ui.query.val() != ''
        data = {}
        data['query'] = @ui.query.val()

        @model.clear()
        @model.set(data)

        @trigger 'search', @model

        Backbone.history.navigate("/search/#{JSURL.stringify(@model.attributes)}", trigger: true)

      return false
