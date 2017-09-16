describe('DotLedger.Views.SortedTransactions.Form', function () {
  var createModel, createView;
  createModel = function () {
    return new DotLedger.Models.SortedTransaction();
  };

  createView = function (model) {
    var categories, transaction, view;
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
    transaction = new DotLedger.Models.Transaction({
      search: 'Some Search',
      account_id: 123,
      id: 345,
      note: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    });
    view = new DotLedger.Views.SortedTransactions.Form({
      model: model,
      transaction: transaction,
      categories: categories
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.SortedTransactions.Form).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.SortedTransactions.Form).toUseTemplate('sorted_transactions/form');
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
    expect(view.$el).toContainElement('select[name=category]');
    expect(view.$el).toContainElement('select[name=category] option[value=11]');
    expect(view.$el).toContainElement('select[name=category] option[value=22]');
    expect(view.$el).toContainElement('select[name=category] option[value=33]');
    expect(view.$el).toContainElement('select[name=category] option[value=44]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Essential]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Flexible]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Income]');
    expect(view.$el).toContainElement('select[name=category] optgroup[label=Transfer]');
    expect(view.$el).not.toContainElement('select[name=category] option[value=Essential]');
    expect(view.$el).not.toContainElement('select[name=category] option[value=Flexible]');
    expect(view.$el).not.toContainElement('select[name=category] option[value=Income]');
    expect(view.$el).not.toContainElement('select[name=category] option[value=Transfer]');
    expect(view.$el).toContainElement('input[name=tags]');
    expect(view.$el).toContainElement('textarea[name=note]');
  });

  it('renders the heading', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/Sort Transaction/);
  });

  it('should set the values on the model when update is called', function () {
    var model, view;
    model = new DotLedger.Models.SortedTransaction();
    view = createView(model).render();
    view.$el.find('input[name=name]').val('New Name');
    view.$el.find('select[name=category]').val('11');
    view.$el.find('input[name=tags]').val('Foo, Bar, Baz');
    view.$el.find('textarea[name=note]').val('Some note...');
    spyOn(model, 'set');
    view.update();
    expect(model.set).toHaveBeenCalledWith({
      name: 'New Name',
      category_id: '11',
      account_id: 123,
      transaction_id: 345,
      tags: 'Foo, Bar, Baz',
      note: 'Some note...'
    });
  });

  it('renders the form fields with the model values', function () {
    var model, view;
    model = new DotLedger.Models.SortedTransaction({
      name: 'Some transaction',
      category_id: '22',
      tag_list: ['Foo', 'Bar', 'Baz'],
      account_id: 123,
      transaction_id: 345,
      note: 'Some note...'
    });
    view = createView(model).render();
    expect(view.$el.find('input[name=name]')).toHaveValue('Some transaction');
    expect(view.$el.find('select[name=category]')).toHaveValue('22');
    expect(view.$el.find('input[name=tags]')).toHaveValue('Foo, Bar, Baz');
    expect(view.$el.find('textarea[name=note]')).toHaveValue('Some note...');
  });
});
