Rahani.module 'Views.Categories', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'categories/list'
    getItemView: -> Rahani.Views.Categories.ListItem
    templateHelpers: ->
      categoryTypes: =>
        types = _.uniq(@collection.pluck('type'))
        _.map types, (type)->
            label: type
            id: "category-type-#{_.string.underscored(type)}"

    appendHtml: (collectionView, itemView, index)->
      list_id =  "category-type-#{_.string.underscored(itemView.model.get('type'))}"
      collectionView.$("div##{list_id}").append(itemView.el)
