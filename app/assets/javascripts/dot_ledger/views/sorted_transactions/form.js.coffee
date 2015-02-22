DotLedger.module 'Views.SortedTransactions', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'sorted_transactions/form'
    className: 'modal'

    behaviors:
      CategorySelector:
        showAnyOption: false
        showNoneOption: false

    ui:
      name: 'input[name=name]'
      category: 'select[name=category]'
      tags: 'input[name=tags]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      @ui.name.val(@model.get('name') || @options.transaction.get('search'))
      @ui.tags.val(@model.get('tag_list'))

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
