describe('DotLedger.Views.Application.Pagination', function () {
  var createCollection, createView;

  createCollection = function () {
    return new DotLedger.Collections.Base();
  };

  createView = function (collection) {
    collection = (collection || createCollection());

    return new DotLedger.Views.Application.Pagination({
      collection: collection
    });
  };

  it('should be defined', function () {
    expect(DotLedger.Views.Application.Pagination).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Application.Pagination).toUseTemplate('application/pagination');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('should not show pagination if pagination is empty', function () {
    var view;
    view = createView();
    expect(view.render().$el.children().length).toEqual(0);
  });

  it('renders the next link disabled if there is no next page', function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    collection.pagination = {
      total_pages: 10
    };
    view = new DotLedger.Views.Application.Pagination({
      collection: collection
    });
    view.render();
    expect(view.$el).toContainElement('.disabled .next');
  });

  it('renders the previous link disabled if there is no previous page', function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    collection.pagination = {
      total_pages: 10
    };
    view = new DotLedger.Views.Application.Pagination({
      collection: collection
    });
    view.render();
    expect(view.$el).toContainElement('.disabled .previous');
  });

  it('fetches the next page when the next link is clicked', function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    collection.pagination = {
      total_pages: 10,
      next_page: 3
    };
    view = new DotLedger.Views.Application.Pagination({
      collection: collection
    });
    spyOn(collection, 'nextPage');
    view.render();
    view.$el.find('.next').click();
    expect(collection.nextPage).toHaveBeenCalled();
  });

  it('fetches the previous page when the previous link is clicked', function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    collection.pagination = {
      total_pages: 10,
      previous_page: 2
    };
    view = new DotLedger.Views.Application.Pagination({
      collection: collection
    });
    spyOn(collection, 'previousPage');
    view.render();
    view.$el.find('.previous').click();
    expect(collection.previousPage).toHaveBeenCalled();
  });

  it('does not fetch the next page when the next link is clicked if there is no next page', function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    collection.pagination = {
      total_pages: 10
    };
    view = new DotLedger.Views.Application.Pagination({
      collection: collection
    });
    spyOn(collection, 'nextPage');
    view.render();
    view.$el.find('.next').click();
    expect(collection.nextPage).not.toHaveBeenCalled();
  });

  it('does not fetch the previous page when the previous link is clicked if there is no previous page', function () {
    var collection, view;
    collection = new DotLedger.Collections.Base();
    collection.pagination = {
      total_pages: 10
    };
    view = new DotLedger.Views.Application.Pagination({
      collection: collection
    });
    spyOn(collection, 'previousPage');
    view.render();
    view.$el.find('.previous').click();
    expect(collection.previousPage).not.toHaveBeenCalled();
  });
});
