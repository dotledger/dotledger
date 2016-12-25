DotLedger.module('Views.SavedSearches', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'saved_searches/form',

    behaviors: {
      TagSelector: {},
      CategorySelector: {
        typeSelectable: true
      },
      AccountsSelector: {}
    },

    ui: {
      name: 'input[name=name]',
      query: 'input[name=query]',
      category: 'select[name=category]',
      date_from: 'input[name=date_from]',
      date_to: 'input[name=date_to]',
      period_from: 'select[name=period_from]',
      period_to: 'select[name=period_to]',
      tags: 'select[name=tags]',
      account: 'select[name=account]',
      review: 'select[name=review]'
    },

    events: {
      'click button.search': 'search',
      'submit form': 'search'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      DotLedger.on('options:change', this.renderPeriodFrom, this);
      DotLedger.on('options:change', this.renderPeriodTo, this);
      this.ui.review.append('<option value="">Any</option>');
      this.ui.review.append('<option value="true">Yes</option>');
      this.ui.review.append('<option value="false">No</option>');
      this.ui.review.val(this.model.get('review'));
      this.ui.name.val(this.model.get('name'));
      this.ui.query.val(this.model.get('query'));
      if (this.model.get('date_from')) {
        this.ui.date_from.val(DotLedger.Helpers.Format.queryDate(this.model.get('date_from')));
      }
      if (this.model.get('date_to')) {
        this.ui.date_to.val(DotLedger.Helpers.Format.queryDate(this.model.get('date_to')));
      }
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
      this.renderPeriodFrom();
      this.renderPeriodTo();
    },

    renderPeriodFrom: function (data) {
      data = (data || DotLedgerData);

      this.ui.period_from.empty();
      this.ui.period_from.append($("<option value=''></option>"));
      _.each(data.saved_search_period_from, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '</option>');
        this.ui.period_from.append($option);
      }, this));
      this.ui.period_from.val(this.model.get('period_from'));
    },

    renderPeriodTo: function (data) {
      data = (data || DotLedgerData);

      this.ui.period_to.empty();
      this.ui.period_to.append($("<option value=''></option>"));
      _.each(data.saved_search_period_to, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '</option>');
        this.ui.period_to.append($option);
      }, this));
      this.ui.period_to.val(this.model.get('period_to'));
    },

    events: {
      'click button.save': 'save',
      'submit form': 'save'
    },

    templateHelpers: function () {
      return {
        pageHeader: _.bind(function () {
          if (this.model.has('name')) {
            return this.model.get('name');
          } else {
            return 'New Saved Search';
          }
        }, this)
      };
    },

    update: function () {
      var data;
      data = {};
      if (this.model.id) {
        data['id'] = this.model.id;
      }
      data['name'] = this.ui.name.val();
      data['query'] = this.ui.query.val();
      if (this.ui.category.val()) {
        if (this.ui.category.val().match(/^-?\d+$/)) {
          data['category_type'] = null;
          data['category_id'] = this.ui.category.val();
        } else {
          data['category_id'] = null;
          data['category_type'] = this.ui.category.val();
        }
      }
      data['date_from'] = this.ui.date_from.val();
      data['date_to'] = this.ui.date_to.val();
      data['period_from'] = this.ui.period_from.val();
      data['period_to'] = this.ui.period_to.val();
      data['tag_ids'] = [this.ui.tags.val()];
      data['account_id'] = this.ui.account.val();
      data['review'] = this.ui.review.val();
      this.model.clear();
      this.model.set(data);
    },

    save: function () {
      this.update();
      this.model.save({}, {
        success: _.bind(function () {
          this.trigger('save', this.model);
        }, this)
      });
      return false;
    }
  });
});
