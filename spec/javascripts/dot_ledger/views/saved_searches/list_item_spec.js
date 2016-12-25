describe('DotLedger.Views.SavedSearches.ListItem', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.SavedSearch({
      id: 10,
      name: 'Pizza',
      query: 'Dominos'
    });
  };

  createView = function (model) {
    model = (model || createModel());

    return new DotLedger.Views.SavedSearches.ListItem({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.SavedSearches.ListItem).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.SavedSearches.ListItem).toUseTemplate('saved_searches/list_item');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the name', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Pizza');
  });

  it('renders the edit button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/saved-searches/10/edit"]');
    expect(view.$el).toContainText('Edit');
  });

  it('renders the delete button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a.delete-saved-search');
    expect(view.$el).toContainText('Delete');
  });
});
