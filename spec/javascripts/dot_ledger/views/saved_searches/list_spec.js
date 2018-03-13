describe('DotLedger.Views.SavedSearches.List', function () {
  var createView, createCollection;

  createCollection = function () {
    var collection;
    collection = new DotLedger.Collections.Accounts([
      {
        id: 10,
        name: 'Pizza',
        query: 'Dominos'
      }
    ]);

    return collection;
  };
  createView = function (collection) {
    var view;
    collection = (collection || createCollection());

    view = new DotLedger.Views.SavedSearches.List({
      collection: collection
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.SavedSearches.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.SavedSearches.List).toUseTemplate('saved_searches/list');
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

  it('renders the blank slate text when there are no saved searches', function () {
    var view, collection;
    collection = new Backbone.Collection([]);
    view = createView(collection).render();
    expect(view.$el.find('.blankslate')).toHaveText(/No Saved Searches/);
  });
});
