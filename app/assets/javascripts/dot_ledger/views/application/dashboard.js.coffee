DotLedger.module 'Views.Application', ->
  class @Dashboard extends Backbone.Marionette.Layout
    template: 'application/dashboard'
    regions:
      panelA: '#panel-a'
      panelB: '#panel-b'
      panelC: '#panel-c'
      panelD: '#panel-d'
