Rahani.module 'Views.Payments', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'payments/list'
    getItemView: -> Rahani.Views.Payments.ListItem
    templateHelpers: ->
      paymentDates: =>
        _.sortBy _.uniq(_.flatten(@collection.pluck('upcoming'))), (date)->
          moment(date).format('X')

    appendHtml: (collectionView, itemView, index)->
      # FIXME: this is bad
      _.each itemView.model.get('upcoming'), (date)->
        date_id = "payment-date-#{moment(date).format('X')}"
        view_string = itemView.el.outerHTML
        collectionView.$("table##{date_id} tbody").append(view_string)
