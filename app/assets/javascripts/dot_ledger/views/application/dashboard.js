DotLedger.module('Views.Application', function () {
  this.Dashboard = Backbone.Marionette.LayoutView.extend({
    template: 'application/dashboard',

    regions: {
      panelA: '#panel-a',
      panelB: '#panel-b',
      panelC: '#panel-c',
      panelD: '#panel-d'
    }
  });
});
