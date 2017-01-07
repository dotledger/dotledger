describe('DotLedger.Views.Categories.List', function () {
  var createView;
  createView = function () {
    var collection, view;

    collection = new DotLedger.Collections.Categories([
      {
        id: 11,
        name: 'Category One',
        type: 'Essential'
      }, {
        id: 22,
        name: 'Category Two',
        type: 'Flexible'
      }, {
        id: 33,
        name: 'Category Three',
        type: 'Income'
      }, {
        id: 44,
        name: 'Category Four',
        type: 'Transfer'
      }
    ]);

    view = new DotLedger.Views.Categories.List({
      collection: collection
    });

    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Categories.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Categories.List).toUseTemplate('categories/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the title', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText("Categories");
  });

  it('renders the new category link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/categories/new"]');
    expect(view.$el.find('a[href="/categories/new"]')).toContainText("New Category");
  });

  it('renders the category type headings', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText("Essential");
    expect(view.$el).toContainText("Flexible");
    expect(view.$el).toContainText("Transfer");
    expect(view.$el).toContainText("Income");
  });

  it('renders the categories', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText("Category One");
    expect(view.$el).toContainElement('a[href="/categories/11/edit"]');
    expect(view.$el.find('a[href="/categories/11/edit"]')).toContainText("Edit");

    expect(view.$el).toContainText("Category Two");
    expect(view.$el).toContainElement('a[href="/categories/22/edit"]');
    expect(view.$el.find('a[href="/categories/22/edit"]')).toContainText("Edit");

    expect(view.$el).toContainText("Category Three");
    expect(view.$el).toContainElement('a[href="/categories/33/edit"]');
    expect(view.$el.find('a[href="/categories/33/edit"]')).toContainText("Edit");

    expect(view.$el).toContainText("Category Four");
    expect(view.$el).toContainElement('a[href="/categories/44/edit"]');
    expect(view.$el.find('a[href="/categories/44/edit"]')).toContainText("Edit");
  });
});
