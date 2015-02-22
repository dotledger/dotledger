describe "DotLedger.Views.Reports.IncomeAndExpenses.Table", ->
  createView = ->
    collection =  new DotLedger.Collections.Base

    view = new DotLedger.Views.Reports.IncomeAndExpenses.Table
      collection: collection
    view

  it "should be defined", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Table).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Table).toUseTemplate('reports/income_and_expenses/table')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
