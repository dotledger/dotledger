describe "DotLedger.Views.Payments.List", ->

  createView = ->
    collection = new DotLedger.Collections.Payments()
    new DotLedger.Views.Payments.List(collection: collection)

  it "should be defined", ->
    expect(DotLedger.Views.Payments.List).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Payments.List).toUseTemplate('payments/list')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Payments')
