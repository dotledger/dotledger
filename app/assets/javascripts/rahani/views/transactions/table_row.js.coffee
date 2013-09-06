Rahani.module 'Views.Transactions', ->
  class @TableRow extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'transactions/table_row'
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
