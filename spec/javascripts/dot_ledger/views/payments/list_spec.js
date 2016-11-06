describe('DotLedger.Views.Payments.List', function () {
  var createView;
  createView = function () {
    var collection;
    collection = new DotLedger.Collections.Payments();
    return new DotLedger.Views.Payments.List({
      collection: collection
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Payments.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Payments.List).toUseTemplate('payments/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });
});
