describe "DotLedger.Views.Reports.IncomeAndExpenses.Show", ->
  createView = ->
    new DotLedger.Views.Reports.IncomeAndExpenses.Show()

  it "should be defined", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Show).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Show).toUseTemplate('reports/income_and_expenses/show')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
