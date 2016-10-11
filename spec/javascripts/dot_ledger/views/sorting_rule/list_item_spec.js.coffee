describe "DotLedger.Views.SortingRules.ListItem", ->
  createView = ->
    model =  new DotLedger.Models.SortingRule
      name: 'Some Sorting Rule'
      contains: 'Rule'
      category_name: 'Some Category'
      category_id: 1
      review: true
      id: 1
      tag_list: ['Foo', 'Bar', 'Baz']

    view = new DotLedger.Views.SortingRules.ListItem
      model: model
    view

  it "should be defined", ->
    expect(DotLedger.Views.SortingRules.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.SortingRules.ListItem).toUseTemplate('sorting_rules/list_item')

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

  it "renders review", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Review/)

  it "renders the tag list", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Foo, Bar, Baz/)

  it "renders the edit button", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/sorting-rules/1/edit"]')
    expect(view.$el).toContainText('Edit')

  it "renders the delete button", ->
    view = createView().render()
    expect(view.$el).toContainElement('a.delete-sorting-rule')
    expect(view.$el).toContainText('Delete')