Rahani.module 'Views.Accounts', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'div'
    template: 'accounts/list_item'
    className: 'list-group-item'
