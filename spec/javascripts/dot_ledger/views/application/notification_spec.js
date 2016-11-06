describe('DotLedger.Views.Application.Notification', function () {
  var createModel, createView;

  createModel = function () {
    return new Backbone.Model({
      message: 'Test'
    });
  };

  createView = function (model) {
    model = (model || createModel());

    return new DotLedger.Views.Application.Notification({
      model: model
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.Notification).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.Notification).toUseTemplate('application/notification');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('should be removed when the close button is clicked', function () {
    var view;
    spyOn(DotLedger.Views.Application.Notification.prototype, 'remove');
    view = createView();
    view.render();
    view.ui.close.click();
    expect(view.remove).toHaveBeenCalled();
  });

  it('renders the message', function () {
    var model, view;
    model = new Backbone.Model({
      message: 'Hello, World!'
    });
    view = createView(model);
    view.render();
    expect(view.$el).toContainText('Hello, World!');
  });
});
