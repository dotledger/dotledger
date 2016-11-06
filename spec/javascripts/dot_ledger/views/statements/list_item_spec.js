describe('DotLedger.Views.Statements.ListItem', function () {
  var createView;
  createView = function () {
    var statement, view;
    statement = new DotLedger.Models.Statement({
      id: 11,
      account_id: 1,
      balance: -1223.16,
      from_date: '2015-01-11',
      to_date: '2015-02-11',
      created_at: '2015-02-20T07:52:57.173',
      transaction_count: 211
    });
    view = new DotLedger.Views.Statements.ListItem({
      model: statement
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Statements.ListItem).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Statements.ListItem).toUseTemplate('statements/list_item');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the created at timestamp', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/20 Feb 2015 07:52:57/);
  });

  it('renders the from date', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/11 Jan 2015/);
  });

  it('renders the to date', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/11 Feb 2015/);
  });

  it('renders the transaction count', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/211/);
  });

  it('renders the closing balance', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/\$-1,223\.16/);
  });
});
