DotLedger.module 'Behaviors', ->
  class @CategorySelector extends Marionette.Behavior

    initialize: ->
      # FIXME: This is a hack to make it easier to test.
      if @view.options.categories
        @categories = @view.options.categories
      else
        @categories = new DotLedger.Collections.Categories()
        @categories.fetch()

    defaults:
      showAnyOption: true
      showNoneOption: true
      categorySelect: 'category'
      categoryAttribute: 'category_id'

    onRender: ->
      @categories.on 'sync', =>
        @renderCategories()
      @renderCategories()

    renderCategories: ->
      $categorySelect = @view.ui[@options.categorySelect]

      $categorySelect.empty()

      if @options.showAnyOption
        $categorySelect.append('<option value="">Any</option>')

      if @options.showNoneOption
        $categorySelect.append('<option value="-1">None</option>')

      _.each @categories.groupBy('type'), (categories, label) ->
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) ->
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        $categorySelect.append($optgroup)

      $categorySelect.val(@view.model.get(@options.categoryAttribute))
