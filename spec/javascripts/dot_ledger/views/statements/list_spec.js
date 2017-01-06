describe('DotLedger.Views.Statements.List', function () {
  var createView;
  createView = function () {
    var account, statements, view;
    account = new DotLedger.Models.Account({
      id: 1,
      name: 'Example Account'
    });
    statements = new DotLedger.Collections.Statements([
      {
        id: 11,
        account_id: 1,
        balance: -1223.16,
        from_date: '2015-01-11',
        to_date: '2015-02-11',
        created_at: '2015-02-20T07:52:57.173',
        transaction_count: 211
      }, {
        id: 22,
        account_id: 1,
        balance: 444.23,
        from_date: '2015-01-13',
        to_date: '2015-02-14',
        created_at: '2015-02-20T07:52:09.854',
        transaction_count: 18
      }, {
        id: 33,
        account_id: 1,
        balance: 1101.32,
        from_date: '2015-01-16',
        to_date: '2015-02-16',
        created_at: '2015-02-20T07:51:45.000',
        transaction_count: 42
      }
    ]);
    view = new DotLedger.Views.Statements.List({
      collection: statements,
      account: account
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Statements.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Statements.List).toUseTemplate('statements/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the page title', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Statements for Example Account/);
  });

  it('renders the created at timestamps', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/20 Feb 2015 07:52:57/);
    expect(view.$el).toHaveText(/20 Feb 2015 07:52:09/);
    expect(view.$el).toHaveText(/20 Feb 2015 07:51:45/);
  });

  it('renders the from dates', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/11 Jan 2015/);
    expect(view.$el).toHaveText(/13 Jan 2015/);
    expect(view.$el).toHaveText(/16 Jan 2015/);
  });

  it('renders the to dates', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/11 Feb 2015/);
    expect(view.$el).toHaveText(/14 Feb 2015/);
    expect(view.$el).toHaveText(/16 Feb 2015/);
  });

  it('renders the transaction counts', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/211/);
    expect(view.$el).toHaveText(/18/);
    expect(view.$el).toHaveText(/42/);
  });

  it('renders the closing balances', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/\$-1,223\.16/);
    expect(view.$el).toHaveText(/\$444\.23/);
    expect(view.$el).toHaveText(/\$1,101\.32/);
  });

  it('renders the statement import link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/1/import"]');
  });
});
