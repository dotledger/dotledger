describe "Rahani.Views.Transactions.TableRow", ->
  createView = ->
    model =  new Rahani.Models.Transaction
      name: 'Some Name'
      memo: 'Some Memo'
      amount: '10.00'
      type: 'xfer'
      posted_at: '2013-01-01'
      id: 1

    view = new Rahani.Views.Transactions.TableRow
      model: model
    view

  it "should be defined", ->
    expect(Rahani.Views.Transactions.TableRow).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Transactions.TableRow).toUseTemplate('transactions/table_row')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the name", ->
    view = createView().render()
    expect(view.$el).toContainText('Some Name')

  it "renders the memo", ->
    view = createView().render()
    expect(view.$el).toContainText('Some Memo')

  it "renders the amount", ->
    view = createView().render()
    expect(view.$el).toContainText('$10.00')

  it "renders the posted at date", ->
    view = createView().render()
    expect(view.$el).toContain('time[datetime="2013-01-01"]')
