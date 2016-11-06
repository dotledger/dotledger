DotLedger.module('Views.SortingRules', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'sorting_rules/list',

    childViewContainer: 'table tbody',

    getChildView: function () {
      return DotLedger.Views.SortingRules.ListItem;
    },

    initialize: function () {
      this.pagination = DotLedger.Helpers.pagination(this, this.collection);
    },

    behaviors: {
      TagSelector: {},
      CategorySelector: {
        showNoneOption: false
      }
    },

    ui: {
      query: 'input[name=query]',
      category: 'select[name=category]',
      tags: 'select[name=tags]'
    },

    events: {
      'click button.search': 'search',
      'submit form': 'search'
    },

    onRender: function () {
      this.ui.query.val(this.model.get('query'));
    },

    search: function () {
      var data;
      data = {};
      if (this.ui.query.val() !== '') {
        data['query'] = this.ui.query.val();
      }
      if (this.ui.category.val() !== '') {
        data['category_id'] = this.ui.category.val();
      }
      data['tag_ids'] = this.ui.tags.val();
      data['page'] = 1;
      this.model.clear();
      this.model.set(_.compactObject(data));
      this.trigger('search', this.model);
      return false;
    }
  });
});
