describe('DotLedger.Views.Reports.IncomeAndExpenses.Filter', function () {
  var createModel, createView;

  createModel = function () {
    return new DotLedger.Models.QueryParams({
      period: 90
    });
  };

  createView = function (model) {
    var view;
    model = (model || createModel());

    view = new DotLedger.Views.Reports.IncomeAndExpenses.Filter({
      model: model
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Filter).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Filter).toUseTemplate('reports/income_and_expenses/filter');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('sets the period to active', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('.period.period-90-days.active');
  });
});
