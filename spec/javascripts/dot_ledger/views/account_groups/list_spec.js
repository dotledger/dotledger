describe('DotLedger.Views.AccountGroups.List', function () {
  var createView;
  createView = function () {
    var collection, view;

    collection = new DotLedger.Collections.AccountGroups([
      {
        "id": 1,
        "name": "Group A"
      },
      {
        "id": 2,
        "name": "Group B",
      }
    ]);

    view = new DotLedger.Views.AccountGroups.List({
      collection: collection
    });

    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.AccountGroups.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.AccountGroups.List).toUseTemplate('account_groups/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the title', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText("Account Groups");
  });

  it('renders the new account group link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/account-groups/new"]');
    expect(view.$el.find('a[href="/account-groups/new"]')).toContainText("New Account Group");
  });

  it('renders the account groups', function () {
    var view;
    view = createView().render();

    expect(view.$el).toContainText("Group A");
    expect(view.$el).toContainElement('a[href="/account-groups/1/edit"]');
    expect(view.$el.find('a[href="/account-groups/1/edit"]')).toContainText("Edit");

    expect(view.$el).toContainText("Group B");
    expect(view.$el).toContainElement('a[href="/account-groups/2/edit"]');
    expect(view.$el.find('a[href="/account-groups/2/edit"]')).toContainText("Edit");
  });
});
