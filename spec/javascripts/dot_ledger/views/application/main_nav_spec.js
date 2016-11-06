describe('DotLedger.Views.Application.MainNav', function () {
  var createView;
  createView = function () {
    return new DotLedger.Views.Application.MainNav({
      accounts: new Backbone.Collection()
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.MainNav).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.MainNav).toUseTemplate('application/main_nav');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });
});
