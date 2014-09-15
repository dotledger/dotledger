DotLedger.module 'Views.Transactions', ->
  class @Details extends Backbone.Marionette.ItemView
    template: 'transactions/details'
    className: 'modal'
