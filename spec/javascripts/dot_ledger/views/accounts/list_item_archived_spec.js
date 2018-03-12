describe('DotLedger.Views.Accounts.ListItemArchived', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.Account({
      name: 'Some Account',
      balance: 0.00,
      updated_at: '2013-01-01T01:00:00Z',
      unsorted_transaction_count: 123,
      id: 1,
      archived: true
    });
  };

  createView = function (model) {
    var view;
    model = (model || createModel());

    view = new DotLedger.Views.Accounts.ListItemArchived({
      model: model
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Accounts.ListItemArchived).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Accounts.ListItemArchived).toUseTemplate('accounts/list_item_archived');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the account name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Some Account/);
  });

  it('renders the account link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/1?tab=sorted&page=1"]');
  });

  it('renders the updated at time', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('time[datetime="2013-01-01T01:00:00Z"]');
  });

  it('renders the unarchive link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a.unarchive');
  });
});
