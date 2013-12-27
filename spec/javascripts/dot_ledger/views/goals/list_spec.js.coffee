describe "DotLedger.Views.Goals.List", ->

  createView = ->
    collection = new DotLedger.Collections.Goals()
    new DotLedger.Views.Goals.List(collection: collection)

  it "should be defined", ->
    expect(DotLedger.Views.Goals.List).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Goals.List).toUseTemplate('goals/list')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Goals')

  it "renders the save button", ->
    view = createView().render()
    expect(view.$el).toContain('button.save-all')
    expect(view.$el.find('button.save-all')).toContainText('Save')
