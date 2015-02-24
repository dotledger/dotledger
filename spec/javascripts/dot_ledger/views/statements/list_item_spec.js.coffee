describe "DotLedger.Views.Statements.ListItem", ->
  createView = ->
    statement = new DotLedger.Models.Statement(
      id: 11
      account_id: 1
      balance: -1223.16
      from_date: '2015-01-11'
      to_date: '2015-02-11'
      created_at: '2015-02-20T07:52:57.173' # HACK: These dates are really in UTC
      transaction_count: 211
    )

    view = new DotLedger.Views.Statements.ListItem
      model: statement
    view

  it "should be defined", ->
    expect(DotLedger.Views.Statements.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Statements.ListItem).toUseTemplate('statements/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the created at timestamp", ->
    view = createView().render()
    expect(view.$el).toHaveText(/20 Feb 2015 07:52:57/)

  it "renders the from date", ->
    view = createView().render()
    expect(view.$el).toHaveText(/11 Jan 2015/)

  it "renders the to date", ->
    view = createView().render()
    expect(view.$el).toHaveText(/11 Feb 2015/)

  it "renders the transaction count", ->
    view = createView().render()
    expect(view.$el).toHaveText(/211/)

  it "renders the closing balance", ->
    view = createView().render()
    expect(view.$el).toHaveText(/\$-1,223\.16/)
