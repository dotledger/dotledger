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

    tags = new DotLedger.Collections.Tags [
      {
        id: 55
        name: 'Tag One'
      }
      {
        id: 66
        name: 'Tag Two'
      }
      {
        id: 77
        name: 'Tag Three'
      }
    ]
    view = new DotLedger.Views.Search.FilterForm
      model: model
      categories: categories
      tags: tags

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
    expect(view.$el).toContainElement('input[name=query]')
    expect(view.$el).toContainElement('input[name=date_from]')
    expect(view.$el).toContainElement('input[name=date_to]')
    expect(view.$el).toContainElement('select[name=category]')
    expect(view.$el).toContainElement('option[value=11]')
    expect(view.$el).toContainElement('option[value=22]')
    expect(view.$el).toContainElement('option[value=33]')
    expect(view.$el).toContainElement('option[value=44]')
    expect(view.$el).toContainElement('optgroup[label=Essential]')
    expect(view.$el).toContainElement('optgroup[label=Flexible]')
    expect(view.$el).toContainElement('optgroup[label=Income]')
    expect(view.$el).toContainElement('optgroup[label=Transfer]')
    expect(view.$el).toContainElement('select[name=tags]')
    expect(view.$el).toContainElement('option[value=55]')
    expect(view.$el).toContainElement('option[value=66]')
    expect(view.$el).toContainElement('option[value=77]')
    expect(view.$el).toContainElement('button.search')

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

  it "should trigger a search event", ->
    model = new Backbone.Model()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('coffee')

    spyOn(view, 'trigger')

    view.search()

    expect(view.trigger).toHaveBeenCalledWith('search', model, 1)
