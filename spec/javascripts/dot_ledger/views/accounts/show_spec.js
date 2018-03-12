describe('DotLedger.Views.Accounts.Show', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.Account({
      name: 'Some Account',
      type: 'Savings',
      number: '123',
      id: 1,
      unsorted_transaction_count: 5,
      sorted_transaction_count: 10,
      review_transaction_count: 15,
      balance: 123.45,
      updated_at: '2013-01-01T01:00:00Z',
      account_group_id: 2,
      account_group_name: 'Personal',
      archived: false
    });
  };

  createView = function (model) {
    var queryParams, view;
    model = (model || createModel());

    queryParams = new DotLedger.Models.QueryParams({
      tab: 'sorted',
      page: 1
    });

    view = new DotLedger.Views.Accounts.Show({
      model: model,
      params: queryParams
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Accounts.Show).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Accounts.Show).toUseTemplate('accounts/show');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the account group name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Personal/);
  });

  it('renders the account name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Some Account/);
  });

  it('renders the account type', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Savings/);
  });

  it('renders the account number', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/123/);
  });

  it('renders the updated at time', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('time[datetime="2013-01-01T01:00:00Z"]');
  });

  it('renders the account balance', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/\$123.45/);
  });

  it('renders the account edit link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/1/edit"]');
  });

  it('renders the statement import link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/1/import"]');
  });

  it('renders the archive link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="#"].archive');
    expect(view.$el).not.toContainElement('a[href="#"].unarchive');
  });

  it('renders the unarchive link for archived accounts', function () {
    var view, model;
    model = createModel();
    model.set('archived', true)
    view = createView(model).render();
    expect(view.$el).not.toContainElement('a[href="#"].archive');
    expect(view.$el).toContainElement('a[href="#"].unarchive');
  });

  it('renders the sorted transactions tab link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[data-tab=sorted]');
  });

  it('renders the sorted transactions tab label with count', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText(/Sorted 10/);
  });

  it('renders the review transactions tab link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[data-tab=review]');
  });

  it('renders the unsorted transactions tab label with count', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText(/Unsorted 5/);
  });

  it('renders the unsorted transactions tab link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[data-tab=unsorted]');
  });

  it('renders the review transactions tab label with count', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText(/Review 15/);
  });
});
