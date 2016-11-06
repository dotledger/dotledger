describe('DotLedger.Views.Categories.Form', function () {
  var createModel, createView;

  createModel = function () {
    return new DotLedger.Models.Category();
  };

  createView = function (model) {
    var view;
    model = (model || createModel());

    view = new DotLedger.Views.Categories.Form({
      model: model
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Categories.Form).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Categories.Form).toUseTemplate('categories/form');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the form fields', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('input[name=name]');
    expect(view.$el).toContainElement('select[name=type]');
    expect(view.$el).toContainElement('option[value=Flexible]');
    expect(view.$el).toContainElement('option[value=Essential]');
    expect(view.$el).toContainElement('option[value=Income]');
    expect(view.$el).toContainElement('option[value=Transfer]');
  });

  it('renders the heading for new category', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/New Category/);
  });

  it('renders the heading existing category', function () {
    var model, view;
    model = new DotLedger.Models.Category({
      name: 'Some Category'
    });
    view = createView(model).render();
    expect(view.$el).toHaveText(/Some Category/);
  });

  it('renders the cancel link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/categories"]');
  });

  it('should set the values on the model when update is called', function () {
    var model, view;
    model = new DotLedger.Models.Category();
    view = createView(model).render();
    view.$el.find('input[name=name]').val('Something');
    view.$el.find('select[name=type]').val('Flexible');
    spyOn(model, 'set');
    view.update();
    expect(model.set).toHaveBeenCalledWith({
      name: 'Something',
      type: 'Flexible'
    });
  });

  it('renders the form fields with the model values', function () {
    var model, view;
    model = new DotLedger.Models.Category({
      name: 'Category',
      type: 'Essential'
    });
    view = createView(model).render();
    expect(view.$el.find('input[name=name]')).toHaveValue('Category');
    expect(view.$el.find('select[name=type]')).toHaveValue('Essential');
  });
});
