describe "DotLedger.Views.Payments.Form", ->
  createView = (model = new DotLedger.Models.Payment())->
    categories = new DotLedger.Collections.Categories [
      {
        id: 11
        name: 'Category One'
        type: 'Essential'
      }
      {
        id: 22
        name: 'Category Two'
        type: 'Flexible'
      }
      {
        id: 33
        name: 'Category Three'
        type: 'Income'
      }
      {
        id: 44
        name: 'Transfer In'
        type: 'Transfer'
      }
    ]
    view = new DotLedger.Views.Payments.Form
      model: model
      categories: categories
    view

  it "should be defined", ->
    expect(DotLedger.Views.Payments.Form).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Payments.Form).toUseTemplate('payments/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContainElement('input[name=name]')
    expect(view.$el).toContainElement('input[name=amount]')
    expect(view.$el).toContainElement('select[name=category]')
    expect(view.$el).toContainElement('option[value=11]')
    expect(view.$el).toContainElement('option[value=22]')
    expect(view.$el).toContainElement('option[value=33]')
    expect(view.$el).toContainElement('option[value=44]')
    expect(view.$el).toContainElement('input[name=date]')
    expect(view.$el).toContainElement('input[name=repeat]')
    expect(view.$el).toContainElement('input[name=repeat_interval]')
    expect(view.$el).toContainElement('select[name=repeat_period]')
    expect(view.$el).toContainElement('option[value=Day]')
    expect(view.$el).toContainElement('option[value=Week]')
    expect(view.$el).toContainElement('option[value=Month]')
    expect(view.$el).toContainElement('select[name=type]')
    expect(view.$el).toContainElement('option[value=Spend]')
    expect(view.$el).toContainElement('option[value=Receive]')

  it "renders the heading for new payment", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Payment/)

  it "renders the heading existing payment", ->
    model = new DotLedger.Models.Payment
      name: 'Some Payment'
    view = createView(model).render()
    expect(view.$el).toHaveText(/Some Payment/)

  it "renders the cancel link", ->
    view = createView().render()
    expect(view.$el).toContainElement('a[href="/payments"]')

  it "should set the values on the model when update is called", ->
    model = new DotLedger.Models.Payment()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('Something')
    view.$el.find('input[name=amount]').val('123.00')
    view.$el.find('select[name=category]').val('11')
    view.$el.find('input[name=date]').val('2011-03-06')
    view.$el.find('input[name=repeat]').prop('checked', true)
    view.$el.find('input[name=repeat_interval]').val('3')
    view.$el.find('select[name=repeat_period]').val('Week')
    view.$el.find('select[name=type]').val('Spend')

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'Something'
      amount: '123.00'
      category_id: '11'
      date: '2011-03-06'
      repeat: true
      repeat_interval: '3'
      repeat_period: 'Week'
      type: 'Spend'

  it "renders the form fields with the model values", ->
    model = new DotLedger.Models.Payment
      name: 'Payment'
      amount: '435.24'
      category_id: '22'
      date: '2011-03-06'
      repeat: true
      repeat_interval: '2'
      repeat_period: 'Month'
      type: 'Receive'

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Payment')
    expect(view.$el.find('input[name=amount]')).toHaveValue('435.24')
    expect(view.$el.find('select[name=category]')).toHaveValue('22')
    expect(view.$el.find('input[name=date]')).toHaveValue('2011-03-06')
    expect(view.$el.find('input[name=repeat]')).toBeChecked()
    expect(view.$el.find('input[name=repeat_interval]')).toHaveValue('2')
    expect(view.$el.find('select[name=repeat_period]')).toHaveValue('Month')
    expect(view.$el.find('select[name=type]')).toHaveValue('Receive')
