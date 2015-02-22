describe "DotLedger.Views.Reports.IncomeAndExpenses.TableRow", ->

  spentBalance = ->
    model = new Backbone.Model
    model.set(
      id: 10
      name: "Bank Charges"
      net: "-27.23"
      received: "0.0"
      spent: "27.23"
      type: "Essential"
    )

  reveivedBalance = ->
    model = new Backbone.Model
    model.set(
      id: 10
      name: "Wages"
      net: "5423.23"
      received: "5423.23"
      spent: "0"
      type: "Income"
    )

  createView = (model = new Backbone.Model) ->
    new DotLedger.Views.Reports.IncomeAndExpenses.TableRow
      model: model

  it "should be defined", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.TableRow).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Reports.IncomeAndExpenses.TableRow).toUseTemplate('reports/income_and_expenses/table_row')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  describe "received", ->
    it "renders the category", ->
      view = createView(reveivedBalance()).render()
      expect(view.$el).toContainText('Wages')

    it "renders the amount", ->
      view = createView(reveivedBalance()).render()
      expect(view.$el).toContainText('$5,423.23')

  describe "spent", ->
    it "renders the category", ->
      view = createView(spentBalance()).render()
      expect(view.$el).toContainText('Bank Charges')

    it "renders the amount", ->
      view = createView(spentBalance()).render()
      expect(view.$el).toContainText('$27.23')
