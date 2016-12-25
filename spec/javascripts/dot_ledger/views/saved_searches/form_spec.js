describe('DotLedger.Views.SavedSearches.Form', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.SavedSearch();
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
    view = new DotLedger.Views.SavedSearches.Form({
      model: model,
      categories: categories,
      tags: tags,
      accounts: accounts
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.SavedSearches.Form).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.SavedSearches.Form).toUseTemplate('saved_searches/form');
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
    expect(view.$el).toContainElement('input[name=query]');
    expect(view.$el).toContainElement('input[name=date_from]');
    expect(view.$el).toContainElement('input[name=date_to]');
    expect(view.$el).toContainElement('select[name=category]');
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

  });

  it('renders the heading for new saved_search', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/New Saved Search/);
  });

  it('renders the heading existing saved_search', function () {
    var model, view;
    model = new DotLedger.Models.SavedSearch({
      name: 'Some Saved Search'
    });
    view = createView(model).render();
    expect(view.$el).toHaveText(/Some Saved Search/);
  });

  it('renders the cancel link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/saved-searches"]');
  });

  it('should set the values on the model when update is called', function () {
    var model, view;
    model = new DotLedger.Models.SavedSearch();
    view = createView(model).render();
    view.$el.find('input[name=name]').val('Something');
    view.$el.find('select[name=category]').val('22')
    spyOn(model, 'set');
    view.update();
    expect(model.set).toHaveBeenCalledWith({
      name: 'Something',
      query: '',
      category_type: null,
      category_id: '22',
      date_from: '',
      date_to: '',
      period_from: '',
      period_to: '',
      tag_ids: [''],
      account_id: '',
      review: ''
    });
  });

  it('renders the form fields with the model values', function () {
    var model, view;
    model = new DotLedger.Models.SavedSearch({
      name: 'Saved Search',
      query: 'Pizza',
      category_id: '11',
      date_from: '2013-03-02',
      date_to: '2013-04-02',
      tag_ids: '',
      account_id: '88',
      review: 'true'
    });
    view = createView(model).render();
    expect(view.$el.find('input[name=name]')).toHaveValue('Saved Search');
    expect(view.$el.find('input[name=query]')).toHaveValue('Pizza');
    expect(view.$el.find('select[name=category]')).toHaveValue('11');
    expect(view.$el.find('input[name=date_from]')).toHaveValue('2013-03-02');
    expect(view.$el.find('input[name=date_to]')).toHaveValue('2013-04-02');
    expect(view.$el.find('select[name=tags]')).toHaveValue('');
    expect(view.$el.find('select[name=account]')).toHaveValue('88');
  });
});
