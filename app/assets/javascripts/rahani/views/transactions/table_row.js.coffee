Rahani.module 'Views.Transactions', ->
  class @TableRow extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'transactions/table_row'
    events:
      'click .sort': 'showSortForm'
    showSortForm: ->
      categories = new Rahani.Collections.Categories()
      categories.fetch()
      sorted_transaction = new Rahani.Models.SortedTransaction()
      form = new Rahani.Views.SortedTransactions.Form
        model: sorted_transaction
        transaction: @model
        categories: categories
      Rahani.modalRegion.show(form)

      form.on 'save', =>
        form.close()
        @remove()

    templateHelpers: ->
      name: =>
        if @model.has('sorted_transaction')
          @model.get('sorted_transaction').name
        else
          @model.get('search')
      category: =>
        if @model.has('sorted_transaction')
          @model.get('sorted_transaction').category_name
        else
          '<a href="#" class="sort btn-xs btn btn-default" title="Sort transaction">Unsorted</a>'
