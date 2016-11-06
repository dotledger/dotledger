DotLedger.module('Views.Payments', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'payments/list',

    getChildView: function () {
      return DotLedger.Views.Payments.ListItem;
    },

    templateHelpers: function () {
      return {
        paymentDates: _.bind(function () {
          return _.sortBy(_.uniq(_.flatten(this.collection.pluck('upcoming'))), function (date) {
            return DotLedger.Helpers.Format.unixTimestamp(date);
          });
        }, this)
      };
    },

    attachHtml: function (collectionView, childView, index) {
      // FIXME: this is bad
      return _.each(childView.model.get('upcoming'), function (date) {
        var dateID, viewString;
        dateID = 'payment-date-' + (DotLedger.Helpers.Format.unixTimestamp(date));
        viewString = childView.el.outerHTML;
        collectionView.$('table#' + dateID + ' tbody').append(viewString);
      });
    }
  });
});
