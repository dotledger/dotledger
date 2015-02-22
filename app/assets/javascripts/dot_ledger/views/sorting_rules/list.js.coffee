DotLedger.module 'Views.SortingRules', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'sorting_rules/list'

    getChildView: -> DotLedger.Views.SortingRules.ListItem

    childViewContainer: 'table tbody'

    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)

    behaviors:
      TagSelector: {}
      CategorySelector:
        showNoneOption: false

    ui:
      query: 'input[name=query]'
      category: 'select[name=category]'
      tags: 'select[name=tags]'

    events:
      'click button.search': 'search'
      'submit form': 'search'

    onRender: ->
      @ui.query.val(@model.get('query'))

    search: ->
      data = {}
      if @ui.query.val() != ''
        data['query'] = @ui.query.val()

      if @ui.category.val() != ''
        data['category_id'] = @ui.category.val()

      data['tag_ids'] = @ui.tags.val()

      @model.clear()
      @model.set(_.compactObject(data))

      # Note: The last argument, 1, is the page number.
      # We want to jump back to the first page when we perform a new search.
      @trigger 'search', @model, 1

      return false
