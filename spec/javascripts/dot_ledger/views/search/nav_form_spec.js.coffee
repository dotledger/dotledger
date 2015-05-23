describe "DotLedger.Views.Search.NavForm", ->
  createView = (model = new DotLedger.Models.QueryParams())->
    view = new DotLedger.Views.Search.NavForm
      model: model
    view

  it "should be defined", ->
    expect(DotLedger.Views.Search.NavForm).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Search.NavForm).toUseTemplate('search/nav_form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContainElement('input[name=query]')
    expect(view.$el).toContainElement('button.search')

  it "should clear the model and set the query", ->
    model = new DotLedger.Models.QueryParams()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('coffee')

    spyOn(model, 'clear')
    spyOn(model, 'set')

    view.search()

    expect(model.clear).toHaveBeenCalled
    expect(model.set).toHaveBeenCalledWith
      query: 'coffee'
      page: 1

  it "should navigate to the search page with a query", ->
    model = new DotLedger.Models.QueryParams()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('coffee')

    spyOn(Backbone.history, 'navigate')

    view.search()

    expect(Backbone.history.navigate).toHaveBeenCalledWith("/search?query=coffee&page=1", { trigger: true })

  it "should navigate to the search page without a query", ->
    model = new DotLedger.Models.QueryParams()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('')

    spyOn(Backbone.history, 'navigate')

    view.search()

    expect(Backbone.history.navigate).toHaveBeenCalledWith("/search?page=1", { trigger: true })
