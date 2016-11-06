describe('DotLedger.Views.Payments.ListItem', function () {
  var createView;
  createView = function () {
    var model;
    model = new DotLedger.Models.Payment({
      id: 1,
      amount: '1000.0',
      name: 'Test Payment',
      type: 'Spend',
      category_id: 1,
      category_name: 'Cash Withdrawals'
    });
    return new DotLedger.Views.Payments.ListItem({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Payments.ListItem).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Payments.ListItem).toUseTemplate('payments/list_item');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Test Payment');
  });

  it('renders the category name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Cash Withdrawals');
  });

  it('renders the amount', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('$1,000.00');
  });

  it('renders the edit button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Edit');
    expect(view.$el).toContainElement('a[href="/payments/1/edit"]');
  });
});
