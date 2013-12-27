describe "DotLedger.Views.Categories.ListItem", ->

  it "should be defined", ->
    expect(DotLedger.Views.Categories.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Categories.ListItem).toUseTemplate('categories/list_item')
