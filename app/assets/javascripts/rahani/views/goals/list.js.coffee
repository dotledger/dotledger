Rahani.module 'Views.Goals', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'goals/list'
    getItemView: -> Rahani.Views.Goals.ListItem
    events:
      'click button.save-all': 'saveAll'
    templateHelpers: ->
      categoryTypes: =>
        types = _.uniq(@collection.pluck('category_type'))
        _.map types, (type)->
          label: type
          id: "category-type-#{_.string.underscored(type)}"

    appendHtml: (collectionView, itemView, index)->
      list_id =  "category-type-#{_.string.underscored(itemView.model.get('category_type'))}"
      collectionView.$("div##{list_id}").append(itemView.el)

    saveAll: ->
      console.log 'test'
      @children.call('save')
