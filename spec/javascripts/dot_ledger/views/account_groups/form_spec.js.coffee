describe "DotLedger.Views.AccountGroups.Form", ->
  createView = (model = new DotLedger.Models.AccountGroup())->
    view = new DotLedger.Views.AccountGroups.Form
      model: model
    view

  it "should be defined", ->
    expect(DotLedger.Views.AccountGroups.Form).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.AccountGroups.Form).toUseTemplate('account_groups/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContainElement('input[name=name]')

  it "renders the heading for new account_group", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Account Group/)

  it "renders the heading existing account_group", ->
    model = new DotLedger.Models.AccountGroup
      name: 'Some Account Group'
    view = createView(model).render()
    expect(view.$el).toHaveText(/Some Account Group/)

  it "renders the cancel link", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/account-groups"]')

  it "should set the values on the model when update is called", ->
    model = new DotLedger.Models.AccountGroup()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('Something')

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'Something'

  it "renders the form fields with the model values", ->
    model = new DotLedger.Models.AccountGroup
      name: 'Account Group'

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Account Group')

