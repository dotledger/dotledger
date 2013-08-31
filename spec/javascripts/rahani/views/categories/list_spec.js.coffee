describe "Rahani.Views.Categories.List", ->

  it "should be defined", ->
    expect(Rahani.Views.Categories.List).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Categories.List).toUseTemplate('categories/list')
