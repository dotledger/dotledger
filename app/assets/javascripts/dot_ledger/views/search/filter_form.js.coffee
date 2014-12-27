DotLedger.module 'Views.Search', ->
  class @FilterForm extends Backbone.Marionette.ItemView
    template: 'search/filter_form'

    ui:
      query: 'input[name=query]'
      category: 'select[name=category]'
      date_from: 'input[name=date_from]'
      date_to: 'input[name=date_to]'
      tags: 'select[name=tags]'

    events:
      'click button.search': 'search'
      'submit form': 'search'

    onRender: ->
      @options.categories.on 'sync', =>
        @renderCategories()
      @options.tags.on 'sync', =>
        @renderTags()
      @ui.query.val(@model.get('query'))
      @ui.date_from.val(@model.get('date_from'))
      @ui.date_to.val(@model.get('date_to'))
      @ui.date_from.datepicker(format: 'yyyy-mm-dd')
      @ui.date_to.datepicker(format: 'yyyy-mm-dd')

      @renderCategories()
      @renderTags()

    renderCategories: ->
      @ui.category.empty()
      @ui.category.append('<option value="">Any</option>')
      @ui.category.append('<option value="-1">None</option>')
      _.each @options.categories.groupBy('type'), (categories, label) =>
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) ->
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        @ui.category.append($optgroup)

      @ui.category.val(@model.get('category_id'))

    renderTags: ->
      @ui.tags.empty()
      @ui.tags.append('<option value="">Any</option>')
      @options.tags.each (tag) =>
        $option = $("<option value='#{tag.get('id')}'>#{tag.get('name')}</option>")
        @ui.tags.append($option)

      @ui.tags.val(@model.get('tag_ids'))

    search: ->
      data = {}
      data['query'] = @ui.query.val()
      if @ui.category.val()
        if @ui.category.val() > 0
          data['category_id'] = @ui.category.val()
        else
          data['unsorted'] = 'true'

      data['date_from'] = @ui.date_from.val()
      data['date_to'] = @ui.date_to.val()
      data['tag_ids'] = @ui.tags.val()

      @model.clear()
      @model.set(_.compactObject(data))

      # Note: The last argument, 1, is the page number.
      # We want to jump back to the first page when we perform a new search.
      @trigger 'search', @model, 1

      return false
