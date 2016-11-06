DotLedger.module('Helpers', function () {
  this.pagination = function (view, collection, selector) {
    var paginationView, renderPagination;

    selector = (selector || '.pager-region');

    paginationView = new DotLedger.Views.Application.Pagination({
      collection: collection
    });

    renderPagination = function () {
      view.$el.find(selector).html(paginationView.render().el);
    };

    view.on('render', renderPagination);
  };
});
