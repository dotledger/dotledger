describe('DotLedger.Views.Application.MainNav', function () {
  var createView;
  createView = function () {
    var collection, view;

    collection = new DotLedger.Collections.Accounts([
      {
        id: 1,
        name: 'Some Account',
        balance: 10.00,
        updated_at: '2013-01-01T01:00:00Z',
        unsorted_transaction_count: 0,
        account_group_id: 1,
        account_group_name: 'Group A'
      }, {
        id: 2,
        name: 'Some Other Account',
        balance: 12.00,
        updated_at: '2013-01-02T01:00:00Z',
        unsorted_transaction_count: 10,
        account_group_id: 1,
        account_group_name: 'Group A'
      }, {
        id: 3,
        name: 'Some Debt',
        balance: -12.00,
        updated_at: '2013-01-03T01:00:00Z',
        unsorted_transaction_count: 12,
        account_group_id: 2,
        account_group_name: 'Group B'
      }
    ]);

    view = new DotLedger.Views.Application.MainNav({
      accounts: collection
    });

    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.MainNav).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.MainNav).toUseTemplate('application/main_nav');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the menu links', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/"]');
    expect(view.$el).toContainElement('a[href="/goals"]');
    expect(view.$el).toContainElement('a[href="/payments"]');
    expect(view.$el).toContainElement('a[href="/reports/income-and-expenses"]');
    expect(view.$el).toContainElement('a[href="/categories"]');
    expect(view.$el).toContainElement('a[href="/sorting-rules"]');
    expect(view.$el).toContainElement('a[href="/account-groups"]');
  });

  it('renders the account links', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/accounts/1"]');
    expect(view.$el).toContainElement('a[href="/accounts/2"]');
    expect(view.$el).toContainElement('a[href="/accounts/3"]');
  });

  it('renders the account groups', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Group A');
    expect(view.$el).toContainText('Group B');
  });
});
