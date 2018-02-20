DotLedger.module('Views.Search', function () {
  this.FilterForm = Backbone.Marionette.ItemView.extend({
    template: 'search/filter_form',

    behaviors: {
      TagSelector: {},
      CategorySelector: {
        typeSelectable: true
      },
      AccountsSelector: {}
    },

    ui: {
      query: 'input[name=query]',
      category: 'select[name=category]',
      date_from: 'input[name=date_from]',
      date_to: 'input[name=date_to]',
      tags: 'select[name=tags]',
      account: 'select[name=account]',
      review: 'select[name=review]'
    },

    events: {
      'click button.search': 'search',
      'submit form': 'search',
      'click a.save-search': 'saveSearch'
    },

    templateHelpers: function () {
      return {
        params: _.bind(function () {
          return _.omit(this.model.attributes, ['page']);
        }, this)
      };
    },

    onRender: function () {
      this.ui.review.append('<option value="">Any</option>');
      this.ui.review.append('<option value="true">Yes</option>');
      this.ui.review.append('<option value="false">No</option>');
      this.ui.review.val(this.model.get('review'));
      this.ui.query.val(this.model.get('query'));
      this.ui.date_from.val(this.model.get('date_from'));
      this.ui.date_to.val(this.model.get('date_to'));
      this.ui.date_from.datepicker({
        format: 'yyyy-mm-dd'
      });
      this.ui.date_to.datepicker({
        format: 'yyyy-mm-dd'
      });
      if (!this.model.has('category_id')) {
        if (this.model.has('category_type')) {
          this.model.set('category_id', this.model.get('category_type'));
        } else if (this.model.has('unsorted')) {
          this.model.set('category_id', '-1');
        }
      }
    },

    update: function () {
      var data;
      data = {};
      data['query'] = this.ui.query.val();
      if (this.ui.category.val()) {
        if (this.ui.category.val() > 0) {
          data['category_id'] = this.ui.category.val();
        } else if (this.ui.category.val() < 0) {
          data['unsorted'] = 'true';
        } else {
          data['category_type'] = this.ui.category.val();
        }
      }
      data['date_from'] = this.ui.date_from.val();
      data['date_to'] = this.ui.date_to.val();
      data['tag_ids'] = this.ui.tags.val();
      data['account_id'] = this.ui.account.val();
      if (this.ui.review.val()) {
        data['review'] = this.ui.review.val();
      }
      data['page'] = 1;
      this.model.clear();
      this.model.set(_.compactObject(data));
    },

    search: function () {
      this.update();
      this.trigger('search', this.model);
      return false;
    },

    saveSearch: function() {
      this.update();
      DotLedger.navigate.newSavedSearch(_.omit(this.model.attributes, ['page']), {
        trigger: true
      });

      return false;
    }
  });
});
