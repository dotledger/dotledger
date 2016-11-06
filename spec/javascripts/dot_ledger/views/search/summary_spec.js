describe('DotLedger.Views.Search.Summary', function () {
  var createCollection, createView;
  createCollection = function () {
    return new DotLedger.Collections.Transactions();
  };

  createView = function (collection) {
    collection = (collection || createCollection());

    return new DotLedger.Views.Search.Summary({
      collection: collection
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Search.Summary).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Search.Summary).toUseTemplate('search/summary');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });
});
