DotLedger.module 'Views.Categories', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'categories/form'

    ui:
      name: 'input[name=name]'
      type: 'select[name=type]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      DotLedger.on 'options:change', @renderCategoryTypes, this

      @ui.name.val(@model.get('name'))

      @renderCategoryTypes()

    renderCategoryTypes: (data = DotLedgerData)->
      @ui.type.empty()
      _.each data.category_types, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.type.append($option)
      @ui.type.val(@model.get('type'))

    events:
      'click button.save': 'save'
      'submit form': 'save'

    templateHelpers: ->
      pageHeader: =>
        if @model.has('name')
          @model.get('name')
        else
          'New Category'

    update: ->
      data =
        name: @ui.name.val()
        type: @ui.type.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
