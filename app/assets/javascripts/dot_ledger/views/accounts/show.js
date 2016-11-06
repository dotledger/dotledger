DotLedger.module('Views.Accounts', function () {
  this.Show = Backbone.Marionette.LayoutView.extend({
    template: 'accounts/show',

    initialize: function (options) {
      this.params = options.params;
    },

    regions: {
      transactions: '#transactions',
      graph: '#graph'
    },

    events: {
      'click a[data-tab]': 'clickTab'
    },

    setActiveTab: function () {
      this.$el.find('a[data-tab]').parent().removeClass('active');
      this.$el.find("a[data-tab='" + (this.params.get('tab')) + "']").parent().addClass('active');
    },

    clickTab: function (event) {
      event.preventDefault();
      this.params.set({
        tab: $(event.target).data('tab')
      });
      this.setActiveTab();
    },

    onRender: function () {
      this.setActiveTab();
    }
  });
});
