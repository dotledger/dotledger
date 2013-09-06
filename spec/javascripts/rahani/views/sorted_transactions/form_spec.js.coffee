describe "Rahani.Views.SortedTransactions.Form", ->
  createView = (model = new Rahani.Models.SortedTransaction())->
    categories = new Rahani.Collections.Categories [
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

    transaction = new Rahani.Models.Transaction
      search: 'Some Search'
      account_id: 123
      id: 345

    view = new Rahani.Views.SortedTransactions.Form
      model: model
      transaction: transaction
      categories: categories
    view

  it "should be defined", ->
    expect(Rahani.Views.SortedTransactions.Form).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.SortedTransactions.Form).toUseTemplate('sorted_transactions/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=name]')
    expect(view.$el).toContain('select[name=category]')
    expect(view.$el).toContain('option[value=11]')
    expect(view.$el).toContain('option[value=22]')
    expect(view.$el).toContain('option[value=33]')
    expect(view.$el).toContain('option[value=44]')
    expect(view.$el).toContain('optgroup[label=Essential]')
    expect(view.$el).toContain('optgroup[label=Flexible]')
    expect(view.$el).toContain('optgroup[label=Income]')
    expect(view.$el).toContain('optgroup[label=Transfer]')

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Sort Transaction/)

  it "should set the values on the model when update is called", ->
    model = new Rahani.Models.SortedTransaction()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('New Name')
    view.$el.find('select[name=category]').val('11')

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'New Name'
      category_id: '11'
      account_id: 123
      transaction_id: 345

  it "renders the form fields with the model values", ->
    model = new Rahani.Models.SortingRule
      name: 'Foobar'
      category_id: '22'

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Foobar')
    expect(view.$el.find('select[name=category]')).toHaveValue('22')
