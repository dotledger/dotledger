describe "DotLedger.Views.Reports.IncomeAndExpenses.Filter", ->
  createView = (model = new DotLedger.Models.QueryParams(period: 90))->

    view = new DotLedger.Views.Reports.IncomeAndExpenses.Filter(
      model: model
    )

    view

  it "should be defined", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Filter).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.Filter).toUseTemplate('reports/income_and_expenses/filter')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "sets the period to active", ->
    view = createView().render()
    expect(view.$el).toContainElement('.period.period-90-days.active')
