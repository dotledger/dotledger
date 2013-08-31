Rahani.module 'Views.Transactions', ->
  class @TableRow extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'transactions/table_row'
