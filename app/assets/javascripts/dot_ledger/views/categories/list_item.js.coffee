DotLedger.module 'Views.Categories', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'div'
    className: 'list-group-item'
    template: 'categories/list_item'
