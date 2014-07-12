DotLedger.module 'Helpers', ->
  @pagination = (view, collection, selector = '.pager-region') ->
    paginationView = new DotLedger.Views.Application.Pagination
      collection: collection

    renderPagination = ->
      view.$el.find(selector).html(paginationView.render().el)

    view.on 'render', renderPagination

    paginationView
