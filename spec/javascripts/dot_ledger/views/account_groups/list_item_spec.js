describe('DotLedger.Views.AccountGroups.ListItem', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.AccountGroup({
      id: 10,
      name: 'Personal'
    });
  };

  createView = function (model) {
    model = (model || createModel());

    return new DotLedger.Views.AccountGroups.ListItem({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.AccountGroups.ListItem).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.AccountGroups.ListItem).toUseTemplate('account_groups/list_item');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Personal');
  });

  it('renders the edit button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/account-groups/10/edit"]');
    expect(view.$el).toContainText('Edit');
  });

  it('renders the delete button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a.delete-account-group');
    expect(view.$el).toContainText('Delete');
  });
});
