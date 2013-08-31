describe "Rahani.Views.Accounts.Show", ->
  createView = ->
    model =  new Rahani.Models.Account
      name: 'Some Account'
      type: 'Savings'
      number: '123'
      id: 1

    view = new Rahani.Views.Accounts.Show
      model: model
    view

  it "should be defined", ->
    expect(Rahani.Views.Accounts.Show).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Accounts.Show).toUseTemplate('accounts/show')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the account name", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Account/)

  it "renders the account type", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Savings/)

  it "renders the account number", ->
    view = createView().render()
    expect(view.$el).toHaveText(/123/)

  it "renders the account edit link", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/accounts/1/edit"]')

  it "renders the statement import link", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/accounts/1/import"]')
