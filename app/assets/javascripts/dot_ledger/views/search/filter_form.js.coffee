DotLedger.module 'Views.Search', ->
  class @FilterForm extends Backbone.Marionette.ItemView
    template: 'search/filter_form'

    ui:
      query: 'input[name=query]'
      category: 'select[name=category]'
      date_from: 'input[name=date_from]'
      date_to: 'input[name=date_to]'

    events:
      'click button.search': 'search'
      'submit form': 'search'

    onRender: ->
      @options.categories.on 'all', =>
        @renderCategories()
      @ui.query.val(@model.get('query'))
      @ui.date_from.val(@model.get('date_from'))
      @ui.date_to.val(@model.get('date_to'))
      @renderCategories()

    renderCategories: ->
      @ui.category.empty()
      @ui.category.append('<option value="">Any</option>')
      _.each @options.categories.groupBy('type'), (categories, label) =>
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) =>
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        @ui.category.append($optgroup)

      @ui.category.val(@model.get('category_id'))

    search: ->
      data = {}
      data['query'] = @ui.query.val()
      data['category_id'] = @ui.category.val()
      data['date_from'] = @ui.date_from.val()
      data['date_to'] = @ui.date_to.val()

      @model.clear()
      @model.set(_.compactObject(data))

      @trigger 'search', @model

      Backbone.history.navigate("/search/#{JSURL.stringify(@model.attributes)}")

      return false
