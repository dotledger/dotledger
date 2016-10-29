$.plot = $.noop

describe "DotLedger.Views.Payments.ProjectedBalanceGraph", ->
  createView = ->
    balances = new DotLedger.Collections.ProjectedBalances

    queryParams = new DotLedger.Models.QueryParams
      period: 90

    view = new DotLedger.Views.Payments.ProjectedBalanceGraph
      params: queryParams
      balances: balances
    view

  it "should be defined", ->
    expect(DotLedger.Views.Payments.ProjectedBalanceGraph).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Payments.ProjectedBalanceGraph).toUseTemplate('payments/projected_balance_graph')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the panel heading", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Projected Balance/)

  it "renders the period tabs", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[data-period=7]')
    expect(view.$el).toContainElement('a[data-period=14]')
    expect(view.$el).toContainElement('a[data-period=30]')
    expect(view.$el).toContainElement('a[data-period=90]')
    expect(view.$el).toContainElement('a[data-period=180]')