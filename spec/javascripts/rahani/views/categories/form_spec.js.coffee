describe "Rahani.Views.Categories.Form", ->
  createView = (model = new Rahani.Models.Category())->
    view = new Rahani.Views.Categories.Form
      model: model
    view

  it "should be defined", ->
    expect(Rahani.Views.Categories.Form).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Categories.Form).toUseTemplate('categories/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=name]')
    expect(view.$el).toContain('select[name=type]')
    expect(view.$el).toContain('option[value=Flexible]')
    expect(view.$el).toContain('option[value=Essential]')
    expect(view.$el).toContain('option[value=Income]')
    expect(view.$el).toContain('option[value=Transfer]')

  it "renders the heading for new category", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Category/)

  it "renders the heading existing category", ->
    model = new Rahani.Models.Category
      name: 'Some Category'
    view = createView(model).render()
    expect(view.$el).toHaveText(/Some Category/)

  it "renders the cancel link", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/categories"]')

  it "should set the values on the model when update is called", ->
    model = new Rahani.Models.Category()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('Something')
    view.$el.find('select[name=type]').val('Flexible')

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'Something'
      type: 'Flexible'

  it "renders the form fields with the model values", ->
    model = new Rahani.Models.Category
      name: 'Category'
      type: 'Essential'

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Category')
    expect(view.$el.find('select[name=type]')).toHaveValue('Essential')

