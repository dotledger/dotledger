describe "DotLedger.Views.Transactions.Table", ->
  createView = ->
    collection =  new DotLedger.Collections.Transactions

    view = new DotLedger.Views.Transactions.Table
      collection: collection
    view

  it "should be defined", ->
    expect(DotLedger.Views.Transactions.Table).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Transactions.Table).toUseTemplate('transactions/table')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
