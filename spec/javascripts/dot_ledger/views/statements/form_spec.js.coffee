describe "DotLedger.Views.Statements.Form", ->
  createView = (statement = new DotLedger.Models.Statement(),
    account = new DotLedger.Models.Account(id: 1, name: 'Some Account'))->
    view = new DotLedger.Views.Statements.Form
      model: statement
      account: account
    view

  it "should be defined", ->
    expect(DotLedger.Views.Statements.Form).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Statements.Form).toUseTemplate('statements/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContainElement('input[name=file]')

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Import Statement/)

  it "renders the account name", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Account/)

  it "renders the cancel link for existing account", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/accounts/1"]')
