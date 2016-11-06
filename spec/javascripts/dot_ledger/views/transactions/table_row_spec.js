describe('DotLedger.Views.Transactions.TableRow', function () {
  var createModel, createView, sortedForReviewTransaction, sortedTransaction;
  sortedTransaction = function () {
    var model;
    model = createModel();
    model.set({
      sorted_transaction: {
        category_name: 'Test Category',
        name: 'Test Sorted Transaction'
      }
    });
    return model;
  };
  sortedForReviewTransaction = function () {
    var model;
    model = createModel();
    model.set({
      sorted_transaction: {
        review: true,
        category_name: 'Test Category',
        name: 'Test Sorted Transaction'
      }
    });
    return model;
  };

  createModel = function () {
    return new DotLedger.Models.Transaction({
      account_name: 'Eftpos',
      search: 'Some Name',
      amount: '10.00',
      posted_at: '2013-01-01',
      id: 1
    });
  };

  createView = function (model, showAccountName) {
    model = (model || createModel());

    return new DotLedger.Views.Transactions.TableRow({
      model: model,
      showAccountName: showAccountName
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Transactions.TableRow).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Transactions.TableRow).toUseTemplate('transactions/table_row');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the amount', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('$10.00');
  });

  it('renders the posted at date', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('time[datetime="2013-01-01"]');
  });

  it('does not render the account name', function () {
    var view;
    view = createView().render();
    expect(view.$el).not.toContainText('Eftpos');
  });

  describe('with showAccountName = true', function () {
    it('renders the account name', function () {
      var view;
      view = createView(createModel(), true).render();
      expect(view.$el).toContainText('Eftpos');
    });
  });

  describe('transaction unsorted', function () {
    it('renders sort button', function () {
      var view;
      view = createView().render();
      expect(view.$el).toContainElement('a.sort-transaction');
    });

    it('renders the search', function () {
      var view;
      view = createView().render();
      expect(view.$el.find('.transaction-details')).toContainText('Some Name');
    });

    it('renders unsorted', function () {
      var view;
      view = createView().render();
      expect(view.$el).toContainText('Unsorted');
    });
  });

  describe('transaction flagged for review', function () {
    it('renders sort button', function () {
      var view;
      view = createView(sortedForReviewTransaction()).render();
      expect(view.$el).toContainElement('a.sort-transaction');
      expect(view.$el.find('a.sort-transaction')).toHaveText('Edit');
    });

    it('renders ok button', function () {
      var view;
      view = createView(sortedForReviewTransaction()).render();
      expect(view.$el).toContainElement('a.review-okay-transaction');
      expect(view.$el.find('a.review-okay-transaction')).toHaveText('Ok');
    });
  });

  describe('transaction sorted', function () {
    it('renders sort button', function () {
      var view;
      view = createView(sortedTransaction()).render();
      expect(view.$el).toContainElement('a.edit-transaction');
      expect(view.$el.find('a.edit-transaction')).toHaveText('Edit');
    });

    it('renders category name', function () {
      var view;
      view = createView(sortedTransaction()).render();
      expect(view.$el).toContainText('Test Category');
    });

    it('renders sorted transaction name', function () {
      var view;
      view = createView(sortedTransaction()).render();
      expect(view.$el).toContainText('Test Sorted Transaction');
    });
  });
});
