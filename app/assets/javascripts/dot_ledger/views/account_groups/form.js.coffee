DotLedger.module 'Views.AccountGroups', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'account_groups/form'

    ui:
      name: 'input[name=name]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      @ui.name.val(@model.get('name'))


    events:
      'click button.save': 'save'
      'submit form': 'save'

    templateHelpers: ->
      pageHeader: =>
        if @model.has('name')
          @model.get('name')
        else
          'New Account Group'

    update: ->
      data =
        name: @ui.name.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
