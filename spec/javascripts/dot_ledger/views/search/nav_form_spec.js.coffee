describe "DotLedger.Views.Search.NavForm", ->
  createView = (model = new Backbone.Model())->
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
    expect(view.$el).toContain('input[name=query]')
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

    expect(Backbone.history.navigate).toHaveBeenCalledWith("/search/~(query~'coffee)/page-1", { trigger: true })
