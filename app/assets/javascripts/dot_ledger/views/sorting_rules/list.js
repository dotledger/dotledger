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
        showNoneOption: false,
        typeSelectable: true
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
      if (!this.model.has('category_id') && this.model.has('category_type')) {
        this.model.set('category_id', this.model.get('category_type'));
      } 
    },

    search: function () {
      var data;
      data = {};
      if (this.ui.query.val() !== '') {
        data['query'] = this.ui.query.val();
      }
      if (this.ui.category.val() !== '') {
        if (this.ui.category.val() > 0) {
          data['category_id'] = this.ui.category.val();
        } else {
          data['category_type'] = this.ui.category.val();
        }
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
