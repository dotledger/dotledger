describe "DotLedger.Views.Search.FilterForm", ->
  createView = (model = new Backbone.Model())->
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
    view = new DotLedger.Views.Search.FilterForm
      model: model
      categories: categories

    view

  it "should be defined", ->
    expect(DotLedger.Views.Search.FilterForm).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Search.FilterForm).toUseTemplate('search/filter_form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=query]')
    expect(view.$el).toContain('input[name=date_from]')
    expect(view.$el).toContain('input[name=date_to]')
    expect(view.$el).toContain('select[name=category]')
    expect(view.$el).toContain('option[value=11]')
    expect(view.$el).toContain('option[value=22]')
    expect(view.$el).toContain('option[value=33]')
    expect(view.$el).toContain('option[value=44]')
    expect(view.$el).toContain('optgroup[label=Essential]')
    expect(view.$el).toContain('optgroup[label=Flexible]')
    expect(view.$el).toContain('optgroup[label=Income]')
    expect(view.$el).toContain('optgroup[label=Transfer]')
    expect(view.$el).toContain('button.search')

  it "should clear the model and set the query", ->
    model = new Backbone.Model()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('coffee')

    spyOn(model, 'clear')
    spyOn(model, 'set')

    view.search()

    expect(model.clear).toHaveBeenCalled
    expect(model.set).toHaveBeenCalledWith
      query: 'coffee'

  it "should navigate to the search page", ->
    model = new Backbone.Model()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('coffee')

    spyOn(Backbone.history, 'navigate')

    view.search()

    expect(Backbone.history.navigate).toHaveBeenCalledWith("/search/~(query~'coffee)")
