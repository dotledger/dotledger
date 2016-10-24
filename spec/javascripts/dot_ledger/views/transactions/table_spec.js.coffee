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

  it "renders the date label", ->
    view = createView().render()
    expect(view.$el).toContainText('Date')

  it "renders the name label", ->
    view = createView().render()
    expect(view.$el).toContainText('Name')

  it "renders the category label", ->
    view = createView().render()
    expect(view.$el).toContainText('Category')

  it "renders the spent label", ->
    view = createView().render()
    expect(view.$el).toContainText('Spent')

  it "renders the received label", ->
    view = createView().render()
    expect(view.$el).toContainText('Received')