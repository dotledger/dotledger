Rahani.module 'Views.SortingRules', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'tr'
    template: 'sorting_rules/list_item'

    templateHelpers: ->
      flag: =>
        if @model.get('review')
          'Review'
