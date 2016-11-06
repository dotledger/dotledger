describe('DotLedger.Views.Reports.IncomeAndExpenses.TableRow', function () {
  var createModel, createView, metadata, reveivedBalance, spentBalance;

  spentBalance = function () {
    var model;
    model = new Backbone.Model();
    model.set({
      id: 10,
      name: 'Bank Charges',
      net: '-27.23',
      received: '0.0',
      spent: '27.23',
      type: 'Essential'
    });
    return model;
  };

  reveivedBalance = function () {
    var model;
    model = new Backbone.Model();
    model.set({
      id: 10,
      name: 'Wages',
      net: '5423.23',
      received: '5423.23',
      spent: '0',
      type: 'Income'
    });
    return model;
  };

  metadata = {
    date_from: '2014-05-10',
    date_to: '2014-05-17'
  };

  createModel = function () {
    return new Backbone.Model();
  };

  createView = function (model) {
    model = (model || createModel());

    return new DotLedger.Views.Reports.IncomeAndExpenses.TableRow({
      model: model,
      metadata: metadata
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.TableRow).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.TableRow).toUseTemplate('reports/income_and_expenses/table_row');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  describe('received', function () {
    it('renders the category', function () {
      var view;
      view = createView(reveivedBalance()).render();
      expect(view.$el).toContainText('Wages');
    });

    it('renders the amount', function () {
      var view;
      view = createView(reveivedBalance()).render();
      expect(view.$el).toContainText('$5,423.23');
    });
  });

  describe('spent', function () {
    it('renders the category', function () {
      var view;
      view = createView(spentBalance()).render();
      expect(view.$el).toContainText('Bank Charges');
    });

    it('renders the amount', function () {
      var view;
      view = createView(spentBalance()).render();
      expect(view.$el).toContainText('$27.23');
    });
  });
});
