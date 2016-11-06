describe('DotLedger.Views.Reports.IncomeAndExpenses.Table', function () {
  var createView;
  createView = function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    view = new DotLedger.Views.Reports.IncomeAndExpenses.Table({
      collection: collection
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Table).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Table).toUseTemplate('reports/income_and_expenses/table');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });
});
