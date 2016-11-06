// = require jquery
// = require bootstrap/button
// = require bootstrap/collapse
// = require bootstrap/dropdown
// = require bootstrap/modal
// = require bootstrap/tab
// = require bootstrap-datepicker
// = require jquery.flot
// = require jquery.flot.pie
// = require jquery.flot.time
// = require moment
// = require underscore
// = require underscore.string
// = require backbone
// = require backbone.babysitter
// = require backbone.wreqr
// = require backbone.marionette
// = require dot_ledger

_.mixin({
  compactObject: function (object) {
    _.each(object, function (v, k) {
      if (_.isEmpty(object[k]) && !_.isNumber(object[k])) {
        delete object[k];
      }
    });
    return object;
  },

  parseQueryString: function (queryString) {
    if (typeof queryString !== 'string' || queryString === '') {
      return {};
    }

    var variables = queryString.trim().replace(/\+/g, ' ').split('&');

    return _.chain(variables)
    .map(function (pair) {
      return pair.split('=');
    })
    .reduce(function (output, pair) {
      var key = decodeURIComponent(pair[0]);
      var value = decodeURIComponent(pair[1] || '');

      if (!(key in output)) {
        output[key] = value;
      } else if (_.isArray(output[key])) {
        output[key].push(value);
      } else {
        output[key] = [output[key], value];
      }
      return output;
    }, {})
    .value();
  }
});
