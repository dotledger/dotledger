describe "DotLedger.Views.Categories.List", ->

  it "should be defined", ->
    expect(DotLedger.Views.Categories.List).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Categories.List).toUseTemplate('categories/list')
