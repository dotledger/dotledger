DotLedger.module('Views.Application', function () {
  this.Pagination = Backbone.Marionette.ItemView.extend({
    template: 'application/pagination',

    events: {
      'click .next': function () {
        if (this.collection.pagination && (this.collection.pagination.next_page != null)) {
          this.collection.nextPage();
        }
        return false;
      },
      'click .previous': function () {
        if (this.collection.pagination && (this.collection.pagination.previous_page != null)) {
          this.collection.previousPage();
        }
        return false;
      }
    },

    initialize: function () {
      this.collection.on('reset sync', _.bind(function () {
        this.render();
      }, this));
    },

    templateHelpers: function () {
      return {
        pagination: this.collection.pagination,
        disablePrevious: _.bind(function () {
          if (this.collection.pagination && (this.collection.pagination.previous_page == null)) {
            return 'disabled';
          }
        }, this),
        disableNext: _.bind(function () {
          if (this.collection.pagination && (this.collection.pagination.next_page == null)) {
            return 'disabled';
          }
        }, this)
      };
    }
  });
});
