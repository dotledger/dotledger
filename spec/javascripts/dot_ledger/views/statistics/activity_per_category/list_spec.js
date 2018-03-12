describe('DotLedger.Views.Statistics.ActivityPerCategory.List', function () {
  var createView, createCollection;

  createCollection = function () {
    var collection;
    collection = new Backbone.Collection([
      {
        id: 3,
        type: 'Flexible',
        name: 'Eating Out',
        goal_amount: '90.0',
        goal_period: 'Month',
        goal: '90.0',
        received: '0.0',
        spent: '44.5',
        net: '-44.5'
      }, {
        id: 5,
        type: 'Flexible',
        name: 'General/Misc',
        goal_amount: '0.0',
        goal_period: 'Month',
        goal: '0.0',
        received: '0.0',
        spent: '13.78',
        net: '-13.78'
      }, {
        id: 15,
        type: 'Essential',
        name: 'Groceries',
        goal_amount: '375.0',
        goal_period: 'Month',
        goal: '375.0',
        received: '0.0',
        spent: '186.59',
        net: '-186.59'
      }
    ]);
    collection.metadata = {
      total_received: '0.0',
      total_spent: '244.87',
      total_net: '-244.87'
    };

    return collection;
  };

  createView = function (collection) {
    var view;
    collection = (collection || createCollection());

    view = new DotLedger.Views.Statistics.ActivityPerCategory.List({
      collection: collection
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Statistics.ActivityPerCategory.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Statistics.ActivityPerCategory.List).toUseTemplate('statistics/activity_per_category/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the category names', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toHaveText(/Eating Out/);
    expect(view.$el.find('.list-group-item:eq(1)')).toHaveText(/General\/Misc/);
    expect(view.$el.find('.list-group-item:eq(2)')).toHaveText(/Groceries/);
  });

  it('renders the spent values', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toContainText('Spent: $44.50');
    expect(view.$el.find('.list-group-item:eq(1)')).toContainText('Spent: $13.78');
    expect(view.$el.find('.list-group-item:eq(2)')).toContainText('Spent: $186.59');
  });

  it('renders the goal values', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toContainText('Goal: $90.00');
    expect(view.$el.find('.list-group-item:eq(1)')).toContainText('Goal: $0.00');
    expect(view.$el.find('.list-group-item:eq(2)')).toContainText('Goal: $375.00');
  });

  it('renders the remaining/overspent values', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toContainText('Remaining: $45.50');
    expect(view.$el.find('.list-group-item:eq(1)')).toContainText('Overspent: $13.78');
    expect(view.$el.find('.list-group-item:eq(2)')).toContainText('Remaining: $188.41');
  });

  it('renders the progress bars', function () {
    var view;
    view = createView().render();
    expect(view.$el.find('.list-group-item:eq(0)')).toContainElement('.progress-bar.progress-bar-success');
    expect(view.$el.find('.list-group-item:eq(1)')).toContainElement('.progress-bar.progress-bar-danger');
    expect(view.$el.find('.list-group-item:eq(2)')).toContainElement('.progress-bar.progress-bar-success');
  });

  it('renders the blank slate text when there is no activity', function () {
    var view, collection;
    collection = new Backbone.Collection([]);
    collection.metadata = {
      total_received: '0.0',
      total_spent: '0.0',
      total_net: '0.0'
    };
    view = createView(collection).render();
    expect(view.$el.find('.blankslate')).toHaveText(/No Activity/);
  });
});
