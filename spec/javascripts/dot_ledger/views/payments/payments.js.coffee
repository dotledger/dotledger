describe "DotLedger.Views.Payments.Payments", ->

  createView = ->
    collection = new DotLedger.Collections.Payments()
    new DotLedger.Views.Payments.Payments(collection: collection)

  it "should be defined", ->
    expect(DotLedger.Views.Payments.Payments).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Payments.Payments).toUseTemplate('payments/payments')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Payments')
