describe('DotLedger.Views.Reports.IncomeAndExpenses.Show', function () {
  var createView;
  createView = function () {
    return new DotLedger.Views.Reports.IncomeAndExpenses.Show();
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Show).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Show).toUseTemplate('reports/income_and_expenses/show');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });
});
