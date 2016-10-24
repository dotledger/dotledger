describe "DotLedger.Views.Transactions.TableRow", ->

  sortedTransaction = ->
    model = createModel()
    model.set
      sorted_transaction:
        category_name: 'Test Category'
        name: 'Test Sorted Transaction'
    model

  sortedForReviewTransaction = ->
    model = createModel()
    model.set
      sorted_transaction:
        review: true
        category_name: 'Test Category'
        name: 'Test Sorted Transaction'
    model

  createModel = ->
    new DotLedger.Models.Transaction
      account_name: 'Eftpos'
      search: 'Some Name'
      amount: '10.00'
      posted_at: '2013-01-01'
      id: 1

  createView = (model = createModel(), showAccountName = undefined) ->
    new DotLedger.Views.Transactions.TableRow
      model: model
      showAccountName: showAccountName

  it "should be defined", ->
    expect(DotLedger.Views.Transactions.TableRow).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Transactions.TableRow).toUseTemplate('transactions/table_row')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the amount", ->
    view = createView().render()
    expect(view.$el).toContainText('$10.00')

  it "renders the posted at date", ->
    view = createView().render()
    expect(view.$el).toContainElement('time[datetime="2013-01-01"]')

  it "does not render the account name", ->
    view = createView().render()
    expect(view.$el).not.toContainText('Eftpos')

  describe "with showAccountName = true", ->
    it "renders the account name", ->
      view = createView(createModel(), true).render()
      expect(view.$el).toContainText('Eftpos')

  describe "transaction unsorted", ->
    it "renders sort button", ->
      view = createView().render()
      expect(view.$el).toContainElement('a.sort-transaction')

    it "renders the search", ->
      view = createView().render()
      expect(view.$el.find('.transaction-details')).toContainText('Some Name')

    it "renders unsorted", ->
      view = createView().render()
      expect(view.$el).toContainText('Unsorted')

  describe "transaction flagged for review", ->
    it "renders sort button", ->
      view = createView(sortedForReviewTransaction()).render()
      expect(view.$el).toContainElement('a.sort-transaction')
      expect(view.$el.find('a.sort-transaction')).toHaveText('Edit')

    it "renders ok button", ->
      view = createView(sortedForReviewTransaction()).render()
      expect(view.$el).toContainElement('a.review-okay-transaction')
      expect(view.$el.find('a.review-okay-transaction')).toHaveText('Ok')

  describe "transaction sorted", ->
    it "renders sort button", ->
      view = createView(sortedTransaction()).render()
      expect(view.$el).toContainElement('a.edit-transaction')
      expect(view.$el.find('a.edit-transaction')).toHaveText('Edit')

    it "renders category name", ->
      view = createView(sortedTransaction()).render()
      expect(view.$el).toContainText('Test Category')

    it "renders sorted transaction name", ->
      view = createView(sortedTransaction()).render()
      expect(view.$el).toContainText('Test Sorted Transaction')
