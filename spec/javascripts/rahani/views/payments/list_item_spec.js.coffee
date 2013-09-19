describe "Rahani.Views.Payments.ListItem", ->

  createView = ->
    model = new Rahani.Models.Payment
      id: 1
      amount: "1000.0"
      name: "Test Payment"
      type: "Spend"
      category_id: 1
      category_name: "Cash Withdrawals"

    new Rahani.Views.Payments.ListItem(model: model)

  it "should be defined", ->
    expect(Rahani.Views.Payments.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Payments.ListItem).toUseTemplate('payments/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the name", ->
    view = createView().render()
    expect(view.$el).toContainText('Test Payment')

  it "renders the category name", ->
    view = createView().render()
    expect(view.$el).toContainText('Cash Withdrawals')

  it "renders the amount", ->
    view = createView().render()
    expect(view.$el).toContainText('$1,000.00')
