describe "Rahani.Views.Transactions.Table", ->
  createView = ->
    collection =  new Rahani.Collections.Transactions

    view = new Rahani.Views.Transactions.Table
      collection: collection
    view

  it "should be defined", ->
    expect(Rahani.Views.Transactions.Table).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Transactions.Table).toUseTemplate('transactions/table')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
