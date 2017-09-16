describe('DotLedger.Views.Search.FilterForm', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.QueryParams();
  };

  createView = function (model) {
    var accounts, categories, tags, view;
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
    tags = new DotLedger.Collections.Tags([
      {
        id: 55,
        name: 'Tag One'
      }, {
        id: 66,
        name: 'Tag Two'
      }, {
        id: 77,
        name: 'Tag Three'
      }
    ]);
    accounts = new DotLedger.Collections.Accounts([
      {
        id: 88,
        name: 'Account One'
      }, {
        id: 99,
        name: 'Account Two'
      }
    ]);
    view = new DotLedger.Views.Search.FilterForm({
      model: model,
      categories: categories,
      tags: tags,
      accounts: accounts
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Search.FilterForm).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Search.FilterForm).toUseTemplate('search/filter_form');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the form fields', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('input[name=query]');
    expect(view.$el).toContainElement('input[name=date_from]');
    expect(view.$el).toContainElement('input[name=date_to]');
    expect(view.$el).toContainElement('select[name=category]');
    expect(view.$el).toContainElement('select[name=category] option[value=Essential]');
    expect(view.$el).toContainElement('select[name=category] option[value=Flexible]');
    expect(view.$el).toContainElement('select[name=category] option[value=Income]');
    expect(view.$el).toContainElement('select[name=category] option[value=Transfer]');
    expect(view.$el).toContainElement('select[name=category] option[value=11]');
    expect(view.$el).toContainElement('select[name=category] option[value=22]');
    expect(view.$el).toContainElement('select[name=category] option[value=33]');
    expect(view.$el).toContainElement('select[name=category] option[value=44]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Essential]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Flexible]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Income]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Transfer]');
    expect(view.$el).toContainElement('select[name=tags]');
    expect(view.$el).toContainElement('select[name=tags] option[value=55]');
    expect(view.$el).toContainElement('select[name=tags] option[value=66]');
    expect(view.$el).toContainElement('select[name=tags] option[value=77]');
    expect(view.$el).toContainElement('select[name=account]');
    expect(view.$el).toContainElement('select[name=account] option[value=88]');
    expect(view.$el).toContainElement('select[name=account] option[value=99]');
    expect(view.$el).toContainElement('select[name=review]');
    expect(view.$el).toContainElement('select[name=review] option[value=""]');
    expect(view.$el).toContainElement('select[name=review] option[value=true]');
    expect(view.$el).toContainElement('select[name=review] option[value=false]');
    expect(view.$el).toContainElement('button.search');
  });

  it('should clear the model and set the query', function () {
    var model, view;
    model = new DotLedger.Models.QueryParams();
    view = createView(model).render();
    view.$el.find('input[name=query]').val('coffee');
    spyOn(model, 'clear');
    spyOn(model, 'set');
    view.search();
    expect(model.clear).toHaveBeenCalled();
    expect(model.set).toHaveBeenCalledWith({
      query: 'coffee',
      page: 1
    });
  });

  it('should search unsorted transactions', function () {
    var model, view;
    model = new DotLedger.Models.QueryParams();
    view = createView(model).render();
    view.$el.find('select[name=category]').val('-1');
    spyOn(model, 'clear');
    spyOn(model, 'set');
    view.search();
    expect(model.clear).toHaveBeenCalled();
    expect(model.set).toHaveBeenCalledWith({
      unsorted: 'true',
      page: 1
    });
  });

  it('should search "for review" transactions', function () {
    var model, view;
    model = new DotLedger.Models.QueryParams();
    view = createView(model).render();
    view.$el.find('select[name=review]').val('true');
    spyOn(model, 'clear');
    spyOn(model, 'set');
    view.search();
    expect(model.clear).toHaveBeenCalled();
    expect(model.set).toHaveBeenCalledWith({
      review: 'true',
      page: 1
    });
  });

  it('should search "not for review" transactions', function () {
    var model, view;
    model = new DotLedger.Models.QueryParams();
    view = createView(model).render();
    view.$el.find('select[name=review]').val('false');
    spyOn(model, 'clear');
    spyOn(model, 'set');
    view.search();
    expect(model.clear).toHaveBeenCalled();
    expect(model.set).toHaveBeenCalledWith({
      review: 'false',
      page: 1
    });
  });

  it('should trigger a search event', function () {
    var model, view;
    model = new Backbone.Model();
    view = createView(model).render();
    view.$el.find('input[name=query]').val('coffee');
    spyOn(view, 'trigger');
    view.search();
    expect(view.trigger).toHaveBeenCalledWith('search', model);
  });
});
