describe('DotLedger.Views.Transactions.Table', function () {
  var createCollection, createView;
  createCollection = function () {
    return new DotLedger.Collections.Transactions();
  };

  createView = function (collection, showAccountName) {
    collection = (collection || createCollection());

    return new DotLedger.Views.Transactions.Table({
      collection: collection,
      showAccountName: showAccountName
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Transactions.Table).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Transactions.Table).toUseTemplate('transactions/table');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the date label', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Date');
  });

  it('renders the name label', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Name');
  });

  it('renders the category label', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Category');
  });

  it('renders the spent label', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Spent');
  });

  it('renders the received label', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Received');
  });

  it('does not render the account label', function () {
    var view;
    view = createView().render();
    expect(view.$el).not.toContainText('Account');
  });

  describe('with showAccountName = true', function () {
    it('renders the account label', function () {
      var view;
      view = createView(createCollection(), true).render();
      expect(view.$el).toContainText('Account');
    });
  });
});
