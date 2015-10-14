$.plot = $.noop

describe "DotLedger.Views.Accounts.BalanceGraph", ->
  createView = ->
    account =  new DotLedger.Models.Account
      id: 1

    queryParams = new DotLedger.Models.QueryParams
      period: 90

    view = new DotLedger.Views.Accounts.BalanceGraph
      params: queryParams
      model: account
    view

  it "should be defined", ->
    expect(DotLedger.Views.Accounts.BalanceGraph).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Accounts.BalanceGraph).toUseTemplate('accounts/balance_graph')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the period tabs", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[data-period=7]')
    expect(view.$el).toContainElement('a[data-period=14]')
    expect(view.$el).toContainElement('a[data-period=30]')
    expect(view.$el).toContainElement('a[data-period=90]')
    expect(view.$el).toContainElement('a[data-period=180]')
    expect(view.$el).toContainElement('a[data-period=mtd]')
    expect(view.$el).toContainElement('a[data-period=ytd]')
