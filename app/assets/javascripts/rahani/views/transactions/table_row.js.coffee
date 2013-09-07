Rahani.module 'Views.Transactions', ->
  class @TableRow extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'transactions/table_row'
    events:
      'click .sort-transaction': 'showSortForm'
      'click .edit-transaction': 'showEditForm'
      'click .review-transaction': 'review'
    showSortForm: ->
      categories = new Rahani.Collections.Categories()
      categories.fetch()
      sorted_transaction = new Rahani.Models.SortedTransaction(
        @model.get('sorted_transaction')
      )
      form = new Rahani.Views.SortedTransactions.Form
        model: sorted_transaction
        transaction: @model
        categories: categories
      Rahani.modalRegion.show(form)

      form.on 'save', =>
        form.close()
        @remove()

    showEditForm: ->
      categories = new Rahani.Collections.Categories()
      categories.fetch()
      sorted_transaction = new Rahani.Models.SortedTransaction(
        @model.get('sorted_transaction')
      )
      form = new Rahani.Views.SortedTransactions.Form
        model: sorted_transaction
        transaction: @model
        categories: categories
      Rahani.modalRegion.show(form)

      form.on 'save', =>
        form.close()

    review: ->
      sorted_transaction = new Rahani.Models.SortedTransaction(
        @model.get('sorted_transaction')
      )

      sorted_transaction.set(review: false)

      sorted_transaction.save {},
        success: =>
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
          '<span class="text-muted">Unsorted</span>'
      editSortReview: =>
        if @model.has('sorted_transaction')
          sorted_transaction = @model.get('sorted_transaction')

          if sorted_transaction.review
            '<a href="#" class="review-transaction btn-xs btn btn-default" title="Review transaction">Ok</a>'
          else
            '<a href="#" class="edit-transaction btn-xs btn btn-default" title="Sort transaction">Edit</a>'
        else
            '<a href="#" class="sort-transaction btn-xs btn btn-default" title="Sort transaction">Sort</a>'
