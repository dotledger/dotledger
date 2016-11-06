describe('DotLedger.Views.Goals.List', function () {
  var createView;
  createView = function () {
    var collection;
    collection = new DotLedger.Collections.Goals();
    return new DotLedger.Views.Goals.List({
      collection: collection
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Goals.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Goals.List).toUseTemplate('goals/list');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the heading', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainText('Goals');
  });

  it('renders the save button', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('button.save-all');
    expect(view.$el.find('button.save-all')).toContainText('Save');
  });
});
