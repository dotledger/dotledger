describe "Rahani.Views.Accounts.ListItem", ->
  createModel = ->
    new Rahani.Models.Account
      name: 'Some Account'
      balance: 10.00
      updated_at: '2013-01-01T01:00:00Z'
      unsorted_transaction_count: 123
      id: 1

  createView = (model = createModel()) ->

    view = new Rahani.Views.Accounts.ListItem
      model: model
    view

  it "should be defined", ->
    expect(Rahani.Views.Accounts.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Accounts.ListItem).toUseTemplate('accounts/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the account name", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Account/)

  it "renders the account link", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/accounts/1"]')

  it "renders the updated at time", ->
    view = createView().render()
    expect(view.$el).toContain('time[datetime="2013-01-01T01:00:00Z"]')

  it "renders unsorted transaction count if greater than 0", ->
    view = createView().render()
    expect(view.$el).toHaveText(/123 unsorted/)

  it "does not render unsorted transaction count if 0", ->
    model = new Rahani.Models.Account
      name: 'Some Account'
      balance: 10.00
      updated_at: '2013-01-01T01:00:00Z'
      unsorted_transaction_count: 0
      id: 1
    view = createView(model).render()
    expect(view.$el).not.toHaveText(/0 unsorted/)
