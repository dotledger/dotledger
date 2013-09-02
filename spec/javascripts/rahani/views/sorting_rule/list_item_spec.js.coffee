describe "Rahani.Views.SortingRules.ListItem", ->
  createView = ->
    model =  new Rahani.Models.SortingRule
      name: 'Some Sorting Rule'
      contains: 'Rule'
      category_name: 'Some Category'
      category_id: 1
      id: 1

    view = new Rahani.Views.SortingRules.ListItem
      model: model
    view

  it "should be defined", ->
    expect(Rahani.Views.SortingRules.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.SortingRules.ListItem).toUseTemplate('sorting_rules/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the name", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Sorting Rule/)

  it "renders the contains", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Rule/)

  it "renders the category name", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Category/)
