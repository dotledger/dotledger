describe('DotLedger.Views.Payments.Payments', function () {
  var createView;
  createView = function () {
    var collection;
    collection = new DotLedger.Collections.Payments();
    return new DotLedger.Views.Payments.Payments({
      collection: collection
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Payments.Payments).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Payments.Payments).toUseTemplate('payments/payments');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the heading', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Payments');
  });
});
