DotLedger.module('Views.Search', function () {
  this.NavForm = Backbone.Marionette.ItemView.extend({
    template: 'search/nav_form',

    ui: {
      query: 'input[name=query]'
    },

    events: {
      'click button.search': 'search',
      'submit form': 'search'
    },

    search: function () {
      var data;
      data = {};
      if (this.ui.query.val() !== '') {
        data['query'] = this.ui.query.val();
      }
      data['page'] = 1;
      this.model.clear();
      this.model.set(data);
      this.trigger('search', this.model);

      // FIXME: This is yuck.
      DotLedger.navigate.search(this.model.attributes, {
        trigger: true
      });
      return false;
    }
  });
});
