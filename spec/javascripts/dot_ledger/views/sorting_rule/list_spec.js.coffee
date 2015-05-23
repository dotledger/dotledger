describe "DotLedger.Views.SortingRules.List", ->
  createView = (search = new DotLedger.Models.QueryParams())->
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
    collection = new DotLedger.Collections.SortingRules(
      [
        {
          id: 1
          contains: 'Old Name'
          name: 'New Name'
          category_id: 11
          category_name: 'Category One'
          review: true
          tag_list: 'Tag One, Tag Two'
        }
        {
          id: 2
          contains: 'Old Other Name'
          name: 'New Other Name'
          category_id: 22
          category_name: 'Category Two'
          review: false
          tag_list: 'Tag One, Tag Three'
        }
      ]
    )
    view = new DotLedger.Views.SortingRules.List
      collection: collection
      model: search
      categories: categories
      tags: tags

    view

  it "should be defined", ->
    expect(DotLedger.Views.SortingRules.List).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.SortingRules.List).toUseTemplate('sorting_rules/list')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContainElement('input[name=query]')
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
    model = new DotLedger.Models.QueryParams()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('cafe')

    spyOn(model, 'clear')
    spyOn(model, 'set')

    view.search()

    expect(model.clear).toHaveBeenCalled
    expect(model.set).toHaveBeenCalledWith
      query: 'cafe'

  it "should trigger a search event", ->
    model = new DotLedger.Models.QueryParams()
    view = createView(model).render()

    view.$el.find('input[name=query]').val('cafe')

    spyOn(view, 'trigger')

    view.search()

    expect(view.trigger).toHaveBeenCalledWith('search', model)

  it "renders the names", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Name/)
    expect(view.$el).toHaveText(/New Other Name/)

  it "renders the contains", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Old Name/)
    expect(view.$el).toHaveText(/Old Other Name/)

  it "renders the category names", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Category One/)
    expect(view.$el).toHaveText(/Category Two/)

  it "renders review", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Review/)

  it "renders the tags", ->
    view = createView().render()
    expect(view.$el).toHaveText(/Tag One, Tag Two/)
    expect(view.$el).toHaveText(/Tag One, Tag Three/)

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Sorting Rules')
