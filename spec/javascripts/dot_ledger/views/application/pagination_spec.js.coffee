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

  it "renders the next link disabled if there is no next page", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10

    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    view.render()

    expect(view.$el).toContainElement('.disabled .next')

  it "renders the previous link disabled if there is no previous page", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10

    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    view.render()

    expect(view.$el).toContainElement('.disabled .previous')

  it "fetches the next page when the next link is clicked", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10
      next_page: 3
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
      previous_page: 2
    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    spyOn(collection, 'previousPage')

    view.render()
    view.$el.find('.previous').click()

    expect(collection.previousPage).toHaveBeenCalled()

  it "does not fetch the next page when the next link is clicked if there is no next page", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10
    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    spyOn(collection, 'nextPage')

    view.render()
    view.$el.find('.next').click()

    expect(collection.nextPage).not.toHaveBeenCalled()

  it "does not fetch the previous page when the previous link is clicked if there is no previous page", ->
    collection = new DotLedger.Collections.Base()
    collection.pagination =
      total_pages: 10
    view = new DotLedger.Views.Application.Pagination(
      collection: collection
    )

    spyOn(collection, 'previousPage')

    view.render()
    view.$el.find('.previous').click()

    expect(collection.previousPage).not.toHaveBeenCalled()
