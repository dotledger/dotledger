DotLedger.module 'Views.SortingRules', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'sorting_rules/form'


    ui:
      name: 'input[name=name]'
      contains: 'input[name=contains]'
      category: 'select[name=category]'
      review: 'select[name=review]'
      tags: 'input[name=tags]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      @options.categories.on 'all', =>
        @renderCategories()

      @ui.name.val(@model.get('name'))
      @ui.contains.val(@model.get('contains'))
      @ui.review.val(@model.get('review')).change()
      @ui.tags.val(@model.get('tag_list'))
      @renderCategories()

    renderCategories: ->
      @ui.category.empty()
      _.each @options.categories.groupBy('type'), (categories, label) =>
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) ->
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        @ui.category.append($optgroup)

      @ui.category.val(@model.get('category_id'))

    events:
      'click button.save': 'save'
      'submit form': 'save'

    templateHelpers: ->
      pageHeader: =>
        if @model.has('name')
          @model.get('name')
        else
          'New Sorting Rule'

    update: ->
      data =
        name: @ui.name.val()
        contains: @ui.contains.val()
        category_id: @ui.category.val()
        review: @ui.review.val()
        tags: @ui.tags.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
