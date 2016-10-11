describe "DotLedger.Views.Categories.ListItem", ->
  createModel = ->
    new DotLedger.Models.Category(
      id: 10
      name: "Bank Charges"
      type: "Essential"
    )

  createView = (model = createModel())->
    new DotLedger.Views.Categories.ListItem(
      model: model
    )

  it "should be defined", ->
    expect(DotLedger.Views.Categories.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Categories.ListItem).toUseTemplate('categories/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the name", ->
    view = createView().render()
    expect(view.$el).toContainText('Bank Charges')

  it "renders the edit button", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/categories/10/edit"]')
    expect(view.$el).toContainText('Edit')

  it "renders the delete button", ->
    view = createView().render()
    expect(view.$el).toContainElement('a.delete-category')
    expect(view.$el).toContainText('Delete')
