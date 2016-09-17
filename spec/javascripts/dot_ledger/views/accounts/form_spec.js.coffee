describe "DotLedger.Views.Accounts.Form", ->
  createView = (model = new DotLedger.Models.Account())->
    account_groups = new DotLedger.Collections.AccountGroups [
      {
        id: 1
        name: 'Personal'
      }
      {
        id: 2
        name: 'Joint'
      }
    ]
    view = new DotLedger.Views.Accounts.Form
      model: model
      account_groups: account_groups
    view

  it "should be defined", ->
    expect(DotLedger.Views.Accounts.Form).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Accounts.Form).toUseTemplate('accounts/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContainElement('input[name=name]')
    expect(view.$el).toContainElement('input[name=number]')
    expect(view.$el).toContainElement('select[name=type]')
    expect(view.$el).toContainElement('select[name=type] option[value=Cheque]')
    expect(view.$el).toContainElement('select[name=type] option[value=Savings]')
    expect(view.$el).toContainElement('select[name=type] option[value="Credit Card"]')
    expect(view.$el).toContainElement('select[name=type] option[value=Other]')
    expect(view.$el).toContainElement('select[name=account_group]')
    expect(view.$el).toContainElement('select[name=account_group] option[value=1]')
    expect(view.$el).toContainElement('select[name=account_group] option[value=2]')

  it "renders the heading for new account", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Account/)

  it "renders the heading for existing account", ->
    model = new DotLedger.Models.Account
      name: 'Some Account'
    view = createView(model).render()
    expect(view.$el).toHaveText(/Some Account/)

  it "renders the cancel link for new account", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/"]')

  it "renders the cancel link for existing account", ->
    model = new DotLedger.Models.Account
      id: 123
    view = createView(model).render()
    expect(view.$el).toContainElement('a[href="/accounts/123"]')

  it "should set the values on the model when update is called", ->
    model = new DotLedger.Models.Account()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('Eftpos')
    view.$el.find('input[name=number]').val('12-1234-1234567-123')
    view.$el.find('select[name=type]').val('Cheque')
    view.$el.find('select[name=account_group]').val("1")

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'Eftpos'
      number: '12-1234-1234567-123'
      type: 'Cheque'
      account_group_id: '1'

  it "renders the form fields with the model values", ->
    model = new DotLedger.Models.Account
      name: 'Account'
      number: '12-1234-1234567-123'
      type: 'Savings'
      account_group_id: 1

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Account')
    expect(view.$el.find('input[name=number]')).toHaveValue('12-1234-1234567-123')
    expect(view.$el.find('select[name=type]')).toHaveValue('Savings')
    expect(view.$el.find('select[name=account_group]')).toHaveValue('1')
