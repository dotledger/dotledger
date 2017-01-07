describe('DotLedger.Views.Application.Dashboard', function () {
  var createView;
  createView = function () {
    return new DotLedger.Views.Application.Dashboard();
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.Dashboard).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.Dashboard).toUseTemplate('application/dashboard');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the title', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Dashboard');
    expect(view.$el).toContainText('My finances');
  });
});
