DotLedger.module('Views.Transactions', function () {
  this.TableRow = Backbone.Marionette.ItemView.extend({
    tagName: 'tr',

    template: 'transactions/table_row',

    events: {
      'click .transaction-details': 'showDetails',
      'click .sort-transaction': 'showSortForm',
      'click .edit-transaction': 'showEditForm',
      'click .review-okay-transaction': 'reviewOkay'
    },

    showDetails: function () {
      var details;
      details = new DotLedger.Views.Transactions.Details({
        model: this.model
      });

      DotLedger.modalRegion.show(details);
    },

    showSortForm: function () {
      var form;
      form = this.sortedTransactionForm();
      form.on('save', _.bind(function () {
        form.destroy();
        this.remove();
      }, this));
    },

    showEditForm: function () {
      var form;
      form = this.sortedTransactionForm();
      form.on('save', function () {
        form.destroy();
      });
    },

    reviewOkay: function () {
      var sortedTransaction;
      sortedTransaction = new DotLedger.Models.SortedTransaction(this.model.get('sorted_transaction'));
      sortedTransaction.set({
        review: false
      });

      sortedTransaction.save({}, {
        success: _.bind(function () {
          this.remove();
        }, this)
      });
    },

    sortedTransactionForm: function () {
      var form, sortedTransaction;
      sortedTransaction = new DotLedger.Models.SortedTransaction(this.model.get('sorted_transaction'));
      sortedTransaction.set({
        review: false
      });

      form = new DotLedger.Views.SortedTransactions.Form({
        model: sortedTransaction,
        transaction: this.model
      });

      DotLedger.modalRegion.show(form);
      return form;
    },

    templateHelpers: function () {
      return {
        showAccountName: _.bind(function () {
          return !!this.options.showAccountName;
        }, this),
        accountName: _.bind(function () {
          return this.model.get('account_name');
        }, this),
        name: _.bind(function () {
          if (this.model.has('sorted_transaction')) {
            return this.model.get('sorted_transaction').name;
          } else {
            return this.model.get('search');
          }
        }, this),
        category: _.bind(function () {
          if (this.model.has('sorted_transaction')) {
            return _.escape(this.model.get('sorted_transaction').category_name);
          } else {
            return '<span class="text-muted">Unsorted</span>';
          }
        }, this),
        spentAmount: _.bind(function () {
          if (this.model.get('amount') < 0) {
            return DotLedger.Helpers.Format.money(-this.model.get('amount'));
          }
        }, this),
        receivedAmount: _.bind(function () {
          if (this.model.get('amount') > 0) {
            return DotLedger.Helpers.Format.money(this.model.get('amount'));
          }
        }, this),
        editSortReview: _.bind(function () {
          var sortedTransaction;
          if (this.model.has('sorted_transaction')) {
            sortedTransaction = this.model.get('sorted_transaction');
            if (sortedTransaction.review) {
              return '<div class="btn-group">' + '<a href="#" class="review-okay-transaction btn-xs btn btn-default" title="Ok">Ok</a>' + '<a href="#" class="sort-transaction btn-xs btn btn-default" title="Edit">Edit</a>' + '</div>';
            } else {
              return '<a href="#" class="edit-transaction btn-xs btn btn-default" title="Edit">Edit</a>';
            }
          } else {
            return '<a href="#" class="sort-transaction btn-xs btn btn-default" title="Sort">Sort</a>';
          }
        }, this)
      };
    }
  });
});
