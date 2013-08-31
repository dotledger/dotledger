describe "Rahani.Views.Statements.Form", ->
  createView = (statement = new Rahani.Models.Statement(),
    account = new Rahani.Models.Account(id: 1, name: 'Some Account'))->
    view = new Rahani.Views.Statements.Form
      model: statement
      account: account
    view

  it "should be defined", ->
    expect(Rahani.Views.Statements.Form).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Statements.Form).toUseTemplate('statements/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=file]')

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Import Statement/)

  it "renders the account name", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Account/)

  it "renders the cancel link for existing account", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/accounts/1"]')
