describe "Rahani.Views.Accounts.Form", ->
  createView = (model = new Rahani.Models.Account())->
    view = new Rahani.Views.Accounts.Form
      model: model
    view

  it "should be defined", ->
    expect(Rahani.Views.Accounts.Form).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Accounts.Form).toUseTemplate('accounts/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=name]')
    expect(view.$el).toContain('input[name=number]')
    expect(view.$el).toContain('select[name=type]')
    expect(view.$el).toContain('option[value=Cheque]')
    expect(view.$el).toContain('option[value=Savings]')
    expect(view.$el).toContain('option[value="Credit Card"]')
    expect(view.$el).toContain('option[value=Other]')

  it "renders the heading for new account", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Account/)

  it "renders the heading for existing account", ->
    model = new Rahani.Models.Account
      name: 'Some Account'
    view = createView(model).render()
    expect(view.$el).toHaveText(/Some Account/)

  it "renders the cancel link for new account", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/"]')

  it "renders the cancel link for existing account", ->
    model = new Rahani.Models.Account
      id: 123
    view = createView(model).render()
    expect(view.$el).toContain('a[href="/accounts/123"]')

  it "should set the values on the model when update is called", ->
    model = new Rahani.Models.Account()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('Eftpos')
    view.$el.find('input[name=number]').val('12-1234-1234567-123')
    view.$el.find('select[name=type]').val('Cheque')

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'Eftpos'
      number: '12-1234-1234567-123'
      type: 'Cheque'

  it "renders the form fields with the model values", ->
    model = new Rahani.Models.Account
      name: 'Account'
      number: '12-1234-1234567-123'
      type: 'Savings'

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Account')
    expect(view.$el.find('input[name=number]')).toHaveValue('12-1234-1234567-123')
    expect(view.$el.find('select[name=type]')).toHaveValue('Savings')
