DotLedger.module 'Views.Payments', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'payments/list'

    getChildView: -> DotLedger.Views.Payments.ListItem

    templateHelpers: ->
      paymentDates: =>
        _.sortBy _.uniq(_.flatten(@collection.pluck('upcoming'))), (date)->
          DotLedger.Helpers.Format.unixTimestamp(date)

    attachHtml: (collectionView, childView, index)->
      # FIXME: this is bad
      _.each childView.model.get('upcoming'), (date)->
        date_id = "payment-date-#{DotLedger.Helpers.Format.unixTimestamp(date)}"
        view_string = childView.el.outerHTML
        collectionView.$("table##{date_id} tbody").append(view_string)
