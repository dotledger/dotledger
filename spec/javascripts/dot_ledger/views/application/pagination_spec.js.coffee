describe "DotLedger.Views.Application.Pagination", ->
  createView = (collection = new DotLedger.Collections.Base()) ->
    new DotLedger.Views.Application.Pagination(
      collection: collection
    )

  it "should be defined", ->
    expect(DotLedger.Views.Application.Pagination).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Application.Pagination).toUseTemplate('application/pagination')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "should not show pagination if pagination is empty", ->
    view = createView()
    expect(view.render().$el.children().length).toEqual(0)

  it "fetches the next page when the next link is clicked", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10
    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    spyOn(collection, 'nextPage')

    view.render()
    view.$el.find('.next').click()

    expect(collection.nextPage).toHaveBeenCalled()

  it "fetches the previous page when the previous link is clicked", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10
    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    spyOn(collection, 'previousPage')

    view.render()
    view.$el.find('.previous').click()

    expect(collection.previousPage).toHaveBeenCalled()
