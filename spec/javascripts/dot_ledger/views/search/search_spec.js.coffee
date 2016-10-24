describe "DotLedger.Views.Search.Search", ->

  createView = ->
    new DotLedger.Views.Search.Search()

  it "should be defined", ->
    expect(DotLedger.Views.Search.Search).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Search.Search).toUseTemplate('search/search')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()