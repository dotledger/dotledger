DotLedger.module 'Views.Payments', ->
  class @Payments extends Backbone.Marionette.LayoutView

    template: 'payments/payments'

    regions:
      graph: '#graph'
      payments: '#payments'