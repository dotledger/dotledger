// = require_self
// = require ./account
// = require ./account_group
// = require ./balance
// = require ./category
// = require ./goal
// = require ./payment
// = require ./query_params
// = require ./sorted_transaction
// = require ./sorting_rule
// = require ./statement
// = require ./tag
// = require ./transaction

DotLedger.module('Models', function () {
  this.Base = Backbone.Model.extend({
    constructor: function () {
      Backbone.Model.prototype.constructor.apply(this, _.toArray(arguments));
      this.listenTo(this, 'error', this.serverSideErrors);
    },

    serverSideErrors: function (model, resp, options) {
      var errors;

      options = (options || {});

      if (resp.status === 422) {
        errors = JSON.parse(resp.responseText).errors;
        model.validationError = errors;

        model.trigger('invalid', model, errors, _.extend(options, {
          validationError: errors
        }));
      }
    }
  });
});
