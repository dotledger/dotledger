// = require_self
// = require ./account_groups
// = require ./accounts
// = require ./balances
// = require ./categories
// = require ./goals
// = require ./index
// = require ./payments
// = require ./projected_balances
// = require ./saved_searches
// = require ./sorting_rules
// = require ./statements
// = require ./tags
// = require ./transactions

DotLedger.module('Collections', function () {
  this.Base = Backbone.Collection.extend({
    pagination: {},

    metadata: {},

    parse: function (response, options) {
      this._fetch_options_data = options.data || {};
      this.pagination = JSON.parse(options.xhr.getResponseHeader('X-Pagination'));
      this.metadata = JSON.parse(options.xhr.getResponseHeader('X-Metadata'));
      return response;
    },

    nextPage: function () {
      var data;
      this.trigger('page:change', this.pagination.next_page);

      if (this.pagination && (this.pagination.next_page != null)) {
        data = _.extend(this._fetch_options_data, {
          page: this.pagination.next_page
        });

        this.fetch({
          reset: true,
          data: data
        });
      }
    },

    previousPage: function () {
      var data;
      this.trigger('page:change', this.pagination.previous_page);

      if (this.pagination && (this.pagination.previous_page != null)) {
        data = _.extend(this._fetch_options_data, {
          page: this.pagination.previous_page
        });

        this.fetch({
          reset: true,
          data: data
        });
      }
    }
  });
});
