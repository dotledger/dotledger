describe('DotLedger.Views.Application.NotFound', function () {
  var createModel, createView;

  createModel = function () {
    return new DotLedger.Models.Base({
      path: '/foo/bar'
    });
  };

  createView = function (model) {
    model = (model || createModel());
    return new DotLedger.Views.Application.NotFound({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.NotFound).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.NotFound).toUseTemplate('application/not_found');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the heading', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Not Found');
  });

  it('renders the path', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('/foo/bar');
  });
});
