Rahani.module 'Views.SortingRules', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'sorting_rules/form'

    initialize: ->
      @options.categories.on 'all', =>
        @render()

    ui:
      name: 'input[name=name]'
      contains: 'input[name=contains]'
      category: 'select[name=category]'

    onRender: ->
      new Rahani.Helpers.FormErrors(@model, @$el)

      _.each @options.categories.groupBy('type'), (categories, label) =>
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) =>
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        @ui.category.append($optgroup)

      @ui.name.val(@model.escape('name'))
      @ui.contains.val(@model.escape('contains'))
      @ui.category.val(@model.escape('category_id'))

    events:
      'click button.save': 'save'
      'submit form': 'save'

    update: ->
      data =
        name: @ui.name.val()
        contains: @ui.contains.val()
        category_id: @ui.category.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
