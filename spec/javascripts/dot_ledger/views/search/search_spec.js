describe('DotLedger.Views.Search.Search', function () {
  var createView;
  createView = function () {
    return new DotLedger.Views.Search.Search();
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Search.Search).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Search.Search).toUseTemplate('search/search');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });
});
