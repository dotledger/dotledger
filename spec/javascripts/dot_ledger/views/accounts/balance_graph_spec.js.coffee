$.plot = $.noop

describe "DotLedger.Views.Accounts.BalanceGraph", ->
  createView = ->
    account =  new DotLedger.Models.Account
      id: 1

    balances = new DotLedger.Collections.Balances

    view = new DotLedger.Views.Accounts.BalanceGraph
      balances: balances
      model: account
    view

  it "should be defined", ->
    expect(DotLedger.Views.Accounts.BalanceGraph).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Accounts.BalanceGraph).toUseTemplate('accounts/balance_graph')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
