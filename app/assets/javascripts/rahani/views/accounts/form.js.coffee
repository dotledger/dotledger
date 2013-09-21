Rahani.module 'Views.Accounts', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'accounts/form'

    ui:
      name: 'input[name=name]'
      number: 'input[name=number]'
      type: 'select[name=type]'

    onRender: ->
      new Rahani.Helpers.FormErrors(@model, @$el)
      _.each RahaniData.account_types, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.type.append($option)

      @ui.name.val(@model.get('name'))
      @ui.number.val(@model.get('number'))
      @ui.type.val(@model.get('type'))

    events:
      'click button.save': 'save'
      'submit form': 'save'

    templateHelpers: ->
      pageHeader: =>
        if @model.has('name')
          @model.get('name')
        else
          'New Account'
      cancelPath: =>
        if @model.get('id')
          "/accounts/#{@model.get('id')}"
        else
          "/" 

    update: ->
      data =
        name: @ui.name.val()
        number: @ui.number.val()
        type: @ui.type.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
