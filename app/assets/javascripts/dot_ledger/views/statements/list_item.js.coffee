DotLedger.module 'Views.Statements', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'tr'

    template: 'statements/list_item'
