describe "Rahani.Views.Payments.List", ->

  createView = ->
    collection = new Rahani.Collections.Payments()
    new Rahani.Views.Payments.List(collection: collection)

  it "should be defined", ->
    expect(Rahani.Views.Payments.List).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Payments.List).toUseTemplate('payments/list')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Payments')
