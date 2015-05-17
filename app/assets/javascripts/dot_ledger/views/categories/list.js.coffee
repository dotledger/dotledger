DotLedger.module 'Views.Categories', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'categories/list'
    getChildView: -> DotLedger.Views.Categories.ListItem
    templateHelpers: ->
      categoryTypes: =>
        types = _.uniq(@collection.pluck('type'))
        _.map types, (type)->
          label: type
          id: "category-type-#{s.underscored(type)}"

    attachHtml: (collectionView, childView, index)->
      list_id =  "category-type-#{s.underscored(childView.model.get('type'))}"
      collectionView.$("div##{list_id}").append(childView.el)
