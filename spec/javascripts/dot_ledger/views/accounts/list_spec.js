describe('DotLedger.Views.Accounts.List', function () {
  var createView;
  createView = function () {
    return new DotLedger.Views.Accounts.List();
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Accounts.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Accounts.List).toUseTemplate('accounts/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the title', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Accounts');
  });

  it('renders the New Account link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/new"]');
  });
});
