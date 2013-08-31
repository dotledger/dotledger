describe "Rahani.Views.Categories.ListItem", ->

  it "should be defined", ->
    expect(Rahani.Views.Categories.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Categories.ListItem).toUseTemplate('categories/list_item')
