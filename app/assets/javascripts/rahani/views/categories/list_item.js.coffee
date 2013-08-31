Rahani.module 'Views.Categories', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'categories/list_item'
