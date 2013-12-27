describe "DotLedger.Views.Accounts.List", ->
  createView = ->
    collection =  new DotLedger.Collections.Accounts(
      [
        {
          id: 1
          name: 'Some Account'
          balance: 10.00
          updated_at: '2013-01-01T01:00:00Z'
          unsorted_transaction_count: 0
        }
        {
          id: 2
          name: 'Some Other Account'
          balance: 12.00
          updated_at: '2013-01-02T01:00:00Z'
          unsorted_transaction_count: 10
        }
        {
          id: 3
          name: 'Some Debt'
          balance: -12.00
          updated_at: '2013-01-03T01:00:00Z'
          unsorted_transaction_count: 12
        }
      ]
    )
    view = new DotLedger.Views.Accounts.List
      collection: collection
    view

  it "should be defined", ->
    expect(DotLedger.Views.Accounts.List).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Accounts.List).toUseTemplate('accounts/list')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the account names", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Some Account/)
    expect(view.$el).toHaveText(/Some Other Account/)
    expect(view.$el).toHaveText(/Some Debt/)

  it "renders the account links", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/accounts/1"]')
    expect(view.$el).toContain('a[href="/accounts/2"]')
    expect(view.$el).toContain('a[href="/accounts/3"]')

  it "renders the udated at times", ->
    view = createView().render()
    expect(view.$el).toContain('time[datetime="2013-01-01T01:00:00Z"]')
    expect(view.$el).toContain('time[datetime="2013-01-02T01:00:00Z"]')
    expect(view.$el).toContain('time[datetime="2013-01-03T01:00:00Z"]')


  it "render the unsorted transaction counts", ->
    view = createView().render()
    expect(view.$el).toHaveText(/12 unsorted/)
    expect(view.$el).toHaveText(/10 unsorted/)

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Accounts')

  it "renders the total cash", ->
    view = createView().render()
    expect(view.$el.text()).toContain('Total cash: $22.00')

  it "renders the total debt", ->
    view = createView().render()
    expect(view.$el.text()).toContain('Total debt: $12.00')

  it "renders the difference", ->
    view = createView().render()
    expect(view.$el.text()).toContain('Difference: $10.00')
