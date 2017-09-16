describe('DotLedger.Views.SortingRules.Form', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.SortingRule();
  };

  createView = function (model) {
    var categories, view;
    model = (model || createModel());

    categories = new DotLedger.Collections.Categories([
      {
        id: 11,
        name: 'Category One',
        type: 'Essential'
      }, {
        id: 22,
        name: 'Category Two',
        type: 'Flexible'
      }, {
        id: 33,
        name: 'Category Three',
        type: 'Income'
      }, {
        id: 44,
        name: 'Transfer In',
        type: 'Transfer'
      }
    ]);
    view = new DotLedger.Views.SortingRules.Form({
      model: model,
      categories: categories
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.SortingRules.Form).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.SortingRules.Form).toUseTemplate('sorting_rules/form');
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
    expect(view.$el).toContainElement('input[name=contains]');
    expect(view.$el).toContainElement('select[name=category]');
    expect(view.$el).toContainElement('select[name=category] option[value=11]');
    expect(view.$el).toContainElement('select[name=category] option[value=22]');
    expect(view.$el).toContainElement('select[name=category] option[value=33]');
    expect(view.$el).toContainElement('select[name=category] option[value=44]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Essential]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Flexible]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Income]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Transfer]');
    expect(view.$el).toContainElement('select[name=review]');
    expect(view.$el).toContainElement('select[name=review] option[value=true]');
    expect(view.$el).toContainElement('select[name=review] option[value=false]');
    expect(view.$el).toContainElement('input[name=tags]');
  });

  it('renders the heading for new sorting_rule', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/New Sorting Rule/);
  });

  it('renders the heading for existing sorting_rule', function () {
    var model, view;
    model = new DotLedger.Models.SortingRule({
      name: 'Some SortingRule'
    });
    view = createView(model).render();
    expect(view.$el).toHaveText(/Some SortingRule/);
  });

  it('renders the cancel link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/sorting-rules"]');
  });

  it('should set the values on the model when update is called', function () {
    var model, view;
    model = new DotLedger.Models.SortingRule();
    view = createView(model).render();
    view.$el.find('input[name=name]').val('New Name');
    view.$el.find('input[name=contains]').val('Old Name');
    view.$el.find('select[name=category]').val('11');
    view.$el.find('select[name=review]').val('true');
    view.$el.find('input[name=tags]').val('Foo, Bar, Baz');
    spyOn(model, 'set');
    view.update();
    expect(model.set).toHaveBeenCalledWith({
      name: 'New Name',
      contains: 'Old Name',
      category_id: '11',
      review: 'true',
      tags: 'Foo, Bar, Baz'
    });
  });

  it('renders the form fields with the model values', function () {
    var model, view;
    model = new DotLedger.Models.SortingRule({
      name: 'Foobar',
      contains: 'Barfoo',
      category_id: '22',
      review: 'true',
      tag_list: ['Foo', 'Bar', 'Baz']
    });
    view = createView(model).render();
    expect(view.$el.find('input[name=name]')).toHaveValue('Foobar');
    expect(view.$el.find('input[name=contains]')).toHaveValue('Barfoo');
    expect(view.$el.find('select[name=category]')).toHaveValue('22');
    expect(view.$el.find('select[name=review]')).toHaveValue('true');
    expect(view.$el.find('input[name=tags]')).toHaveValue('Foo, Bar, Baz');
  });
});
