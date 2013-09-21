Rahani.module 'Views.Transactions', ->
  class @TableRow extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'transactions/table_row'
    events:
      'click .sort-transaction': 'showSortForm'
      'click .edit-transaction': 'showEditForm'
      'click .review-okay-transaction': 'reviewOkay'
    showSortForm: ->
      form = @sortedTransactionForm()
      form.on 'save', =>
        form.close()
        @remove()

    showEditForm: ->
      form = @sortedTransactionForm()
      form.on 'save', =>
        form.close()

    reviewOkay: ->
      sorted_transaction = new Rahani.Models.SortedTransaction(
        @model.get('sorted_transaction')
      )

      sorted_transaction.set(review: false)

      sorted_transaction.save {},
        success: =>
          @remove()

    sortedTransactionForm: ->
      categories = new Rahani.Collections.Categories()
      categories.fetch()
      sorted_transaction = new Rahani.Models.SortedTransaction(
        @model.get('sorted_transaction')
      )

      sorted_transaction.set(review: false)

      form = new Rahani.Views.SortedTransactions.Form
        model: sorted_transaction
        transaction: @model
        categories: categories
      Rahani.modalRegion.show(form)

      form

    templateHelpers: ->
      name: =>
        if @model.has('sorted_transaction')
          @model.get('sorted_transaction').name
        else
          @model.get('search')
      category: =>
        if @model.has('sorted_transaction')
          _.escape(@model.get('sorted_transaction').category_name)
        else
          '<span class="text-muted">Unsorted</span>'
      spentAmount: =>
        if @model.get('amount') < 0
          accounting.formatMoney(-@model.get('amount'))
      receivedAmount: =>
        if @model.get('amount') > 0
          accounting.formatMoney(@model.get('amount'))
      editSortReview: =>
        if @model.has('sorted_transaction')
          sorted_transaction = @model.get('sorted_transaction')

          if sorted_transaction.review
            '<div class="btn-group">' +
            '<a href="#" class="review-okay-transaction btn-xs btn btn-default" title="Review transaction">Ok</a>' +
            '<a href="#" class="sort-transaction btn-xs btn btn-default" title="Review transaction">Edit</a>' +
            '</div>'
          else
            '<a href="#" class="edit-transaction btn-xs btn btn-default" title="Sort transaction">Edit</a>'
        else
            '<a href="#" class="sort-transaction btn-xs btn btn-default" title="Sort transaction">Sort</a>'
