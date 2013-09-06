describe "Rahani.Views.Transactions.TableRow", ->
  createModel = ->
    new Rahani.Models.Transaction
      search: 'Some Name'
      amount: '10.00'
      posted_at: '2013-01-01'
      id: 1

  createView = (model = createModel()) ->
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

  it "renders the search if the transaction is unsorted", ->
    view = createView().render()
    expect(view.$el).toContainText('Some Name')

  it "renders sorted name if the transaction is sorted", ->
    model = createModel()
    model.set
      sorted_transaction:
        name: 'Sorted Name'
    view = createView(model).render()
    expect(view.$el).toContainText('Sorted Name')

  it "renders the amount", ->
    view = createView().render()
    expect(view.$el).toContainText('$10.00')

  it "renders the posted at date", ->
    view = createView().render()
    expect(view.$el).toContain('time[datetime="2013-01-01"]')

  it "renders unsorted if the transaction is unsorted", ->
    view = createView().render()
    expect(view.$el).toContainText('Unsorted')

  it "renders category name if the transaction is sorted", ->
    model = createModel()
    model.set
      sorted_transaction:
        category_name: 'Foobar'
    view = createView(model).render()
    expect(view.$el).toContainText('Foobar')
