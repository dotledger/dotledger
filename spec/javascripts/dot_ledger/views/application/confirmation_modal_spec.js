describe('DotLedger.Views.Application.ConfirmationModal', function () {
  var createView;

  createView = function (options) {
    options = (options || {});

    return new DotLedger.Views.Application.ConfirmationModal(options);
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.ConfirmationModal).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.ConfirmationModal).toUseTemplate('application/confirmation_modal');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('should be destroyed when the close button is clicked', function () {
    var view;
    spyOn(DotLedger.Views.Application.ConfirmationModal.prototype, 'destroy');
    view = createView();
    view.render();
    view.ui.close.click();
    expect(view.destroy).toHaveBeenCalled();
  });

  it('should be destroyed when the cancel link is clicked', function () {
    var view;
    spyOn(DotLedger.Views.Application.ConfirmationModal.prototype, 'destroy');
    view = createView();
    view.render();
    view.ui.cancel.click();
    expect(view.destroy).toHaveBeenCalled();
  });

  it('should confirm when the confirm button is clicked', function () {
    var view;
    spyOn(DotLedger.Views.Application.ConfirmationModal.prototype, 'confirm');
    view = createView();
    view.render();
    view.ui.confirm.click();
    expect(view.confirm).toHaveBeenCalled();
  });

  it('renders the title', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Are you sure?');
  });

  it('renders the body', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Are you sure you want to continue?');
  });

  it('renders the confirm button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Confirm');
  });

  it('renders the cancel link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Cancel');
  });

  it('renders the custom title', function () {
    var view;
    view = createView({
      title: 'For real?'
    }).render();
    expect(view.$el).toContainText('For real?');
  });

  it('renders the custom body', function () {
    var view;
    view = createView({
      body: 'WARNING!'
    }).render();
    expect(view.$el).toContainText('WARNING!');
  });

  it('renders the custom confirm button', function () {
    var view;
    view = createView({
      confirm: 'YES!'
    }).render();
    expect(view.$el).toContainText('YES!');
  });

  it('renders the custom cancel link', function () {
    var view;
    view = createView({
      cancel: 'No way!'
    }).render();
    expect(view.$el).toContainText('No way!');
  });
});
