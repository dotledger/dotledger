describe('DotLedger.Views.Statistics.ActivityPerCategoryType.List', function () {
  var createView;
  createView = function () {
    var collection, view;
    collection = new Backbone.Collection([
      {
        'net': '-30.0',
        'received': '0.0',
        'spent': '30.0',
        'type': 'Essential'
      }, {
        'net': '-40.0',
        'received': '0.0',
        'spent': '40.0',
        'type': 'Flexible'
      }, {
        'net': '50.0',
        'received': '50.0',
        'spent': '0.0',
        'type': 'Income'
      }, {
        'net': '-70.0',
        'received': '0.0',
        'spent': '70.0',
        'type': 'Uncategorised'
      }
    ]);
    collection.metadata = {
      total_received: '50.0',
      total_spent: '140.0',
      total_net: '-90.0'
    };
    view = new DotLedger.Views.Statistics.ActivityPerCategoryType.List({
      collection: collection
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Statistics.ActivityPerCategoryType.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Statistics.ActivityPerCategoryType.List).toUseTemplate('statistics/activity_per_category_type/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the heading', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.panel-title')).toHaveText(/Month-to-date Summary/);
  });

  it('renders the summary', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.panel-body:eq(0)')).toHaveText(/Total received: \$50.00/);
    expect(view.$el.find('.panel-body:eq(0)')).toHaveText(/Total spent: \$140.00/);
    expect(view.$el.find('.panel-body:eq(0)')).toHaveText(/Difference: \$-90.00/);
  });

  it('renders the category types', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0) .type')).toHaveText(/Essential/);
    expect(view.$el.find('.list-group-item:eq(1) .type')).toHaveText(/Flexible/);
    expect(view.$el.find('.list-group-item:eq(2) .type')).toHaveText(/Income/);
    expect(view.$el.find('.list-group-item:eq(3) .type')).toHaveText(/Uncategorised/);
  });

  it('renders the category received values', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toHaveText(/Received: \$0.00/);
    expect(view.$el.find('.list-group-item:eq(1)')).toHaveText(/Received: \$0.00/);
    expect(view.$el.find('.list-group-item:eq(2)')).toHaveText(/Received: \$50.00/);
    expect(view.$el.find('.list-group-item:eq(3)')).toHaveText(/Received: \$0.00/);
  });

  it('renders the category spent values', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toHaveText(/Spent: \$30.00/);
    expect(view.$el.find('.list-group-item:eq(1)')).toHaveText(/Spent: \$40.00/);
    expect(view.$el.find('.list-group-item:eq(2)')).toHaveText(/Spent: \$0.00/);
    expect(view.$el.find('.list-group-item:eq(3)')).toHaveText(/Spent: \$70.00/);
  });

  it('renders the category difference values', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toHaveText(/Difference: \$-30.00/);
    expect(view.$el.find('.list-group-item:eq(1)')).toHaveText(/Difference: \$-40.00/);
    expect(view.$el.find('.list-group-item:eq(2)')).toHaveText(/Difference: \$50.00/);
    expect(view.$el.find('.list-group-item:eq(3)')).toHaveText(/Difference: \$-70.00/);
  });
});
