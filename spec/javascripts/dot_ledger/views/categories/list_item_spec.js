describe('DotLedger.Views.Categories.ListItem', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.Category({
      id: 10,
      name: 'Bank Charges',
      type: 'Essential'
    });
  };

  createView = function (model) {
    model = (model || createModel());

    return new DotLedger.Views.Categories.ListItem({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Categories.ListItem).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Categories.ListItem).toUseTemplate('categories/list_item');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Bank Charges');
  });

  it('renders the edit button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/categories/10/edit"]');
    expect(view.$el).toContainText('Edit');
  });

  it('renders the delete button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a.delete-category');
    expect(view.$el).toContainText('Delete');
  });
});
