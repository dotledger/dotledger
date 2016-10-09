$.plot = $.noop

describe "DotLedger.Views.Payments.ProjectedBalanceGraph", ->
  createView = ->
    balances = new DotLedger.Collections.ProjectedBalances

    view = new DotLedger.Views.Payments.ProjectedBalanceGraph
      balances: balances
    view

  it "should be defined", ->
    expect(DotLedger.Views.Payments.ProjectedBalanceGraph).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Payments.ProjectedBalanceGraph).toUseTemplate('payments/projected_balance_graph')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
