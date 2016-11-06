describe('DotLedger.Views.Goals.ListItem', function () {
  var createView;
  createView = function () {
    var model;
    model = new DotLedger.Models.Goal({
      id: 1,
      amount: '1000.0',
      period: 'Month',
      type: 'Spend',
      category_id: 1,
      category_name: 'Cash Withdrawals',
      category_type: 'Flexible'
    });
    return new DotLedger.Views.Goals.ListItem({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Goals.ListItem).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Goals.ListItem).toUseTemplate('goals/list_item');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the amount field', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('input[name=amount]');
  });

  it('renders the period select', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('select[name=period]');
  });

  it('renders the type select', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('select[name=type]');
  });

  it('renders the category name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Cash Withdrawals');
  });
});
