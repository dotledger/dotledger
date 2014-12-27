DotLedger.module 'Views.SortedTransactions', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'sorted_transactions/form'
    className: 'modal'
    initialize: ->

    ui:
      name: 'input[name=name]'
      category: 'select[name=category]'
      tags: 'input[name=tags]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      @options.categories.on 'all', =>
        @renderCategories()

      @ui.name.val(@model.get('name') || @options.transaction.get('search'))
      @ui.tags.val(@model.get('tag_list'))

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

    update: ->
      data =
        name: @ui.name.val()
        category_id: @ui.category.val()
        account_id: @options.transaction.get('account_id')
        transaction_id: @options.transaction.get('id')
        tags: @ui.tags.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
