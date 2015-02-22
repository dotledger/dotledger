DotLedger.module 'Views.Search', ->
  class @FilterForm extends Backbone.Marionette.ItemView
    template: 'search/filter_form'

    behaviors:
      TagSelector: {}
      CategorySelector: {}
      AccountsSelector: {}

    ui:
      query: 'input[name=query]'
      category: 'select[name=category]'
      date_from: 'input[name=date_from]'
      date_to: 'input[name=date_to]'
      tags: 'select[name=tags]'
      account: 'select[name=account]'

    events:
      'click button.search': 'search'
      'submit form': 'search'

    onRender: ->
      @ui.query.val(@model.get('query'))
      @ui.date_from.val(@model.get('date_from'))
      @ui.date_to.val(@model.get('date_to'))
      @ui.date_from.datepicker(format: 'yyyy-mm-dd')
      @ui.date_to.datepicker(format: 'yyyy-mm-dd')

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
      data['account_id'] = @ui.account.val()

      @model.clear()
      @model.set(_.compactObject(data))

      # Note: The last argument, 1, is the page number.
      # We want to jump back to the first page when we perform a new search.
      @trigger 'search', @model, 1

      return false
