describe "DotLedger.Views.Search.Summary", ->
  createCollection = ->
    new DotLedger.Collections.Transactions()

  createView = (collection = createCollection())->
    new DotLedger.Views.Search.Summary(
      collection: collection
    )

  it "should be defined", ->
    expect(DotLedger.Views.Search.Summary).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Search.Summary).toUseTemplate('search/summary')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()