describe('DotLedger.Views.Statements.Form', function () {
  var createStatement, createAccount, createView;

  createStatement = function () {
    return new DotLedger.Models.Statement();
  };

  createAccount = function () {
    return new DotLedger.Models.Account({
      id: 1,
      name: 'Some Account'
    });
  };

  createView = function (statement, account) {
    var view;
    statement = (statement || createStatement());
    account = (account || createAccount());

    view = new DotLedger.Views.Statements.Form({
      model: statement,
      account: account
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Statements.Form).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Statements.Form).toUseTemplate('statements/form');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the form fields', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('input[name=file]');
  });

  it('renders the heading', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Import Statement/);
  });

  it('renders the account name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Some Account/);
  });

  it('renders the cancel link for existing account', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/1"]');
  });
});
