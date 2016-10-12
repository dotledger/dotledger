describe "DotLedger.Views.AccountGroups.ListItem", ->
  createModel = ->
    new DotLedger.Models.AccountGroup(
      id: 10
      name: "Personal"
    )

  createView = (model = createModel())->
    new DotLedger.Views.AccountGroups.ListItem(
      model: model
    )

  it "should be defined", ->
    expect(DotLedger.Views.AccountGroups.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.AccountGroups.ListItem).toUseTemplate('account_groups/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the name", ->
    view = createView().render()
    expect(view.$el).toContainText('Personal')

  it "renders the edit button", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/account-groups/10/edit"]')
    expect(view.$el).toContainText('Edit')

  it "renders the delete button", ->
    view = createView().render()
    expect(view.$el).toContainElement('a.delete-account-group')
    expect(view.$el).toContainText('Delete')
