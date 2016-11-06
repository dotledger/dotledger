var slice = [].slice;

DotLedger.module('Views.Application', function () {
  this.MainNav = Backbone.Marionette.ItemView.extend({
    template: 'application/main_nav',

    className: 'navbar navbar-default navbar-fixed-top',

    ui: {
      nav_search: '#nav-search'
    },

    initialize: function () {
      this.options.accounts.on('sync', _.bind(function () {
        this.render();
      }, this));

      this.active = 'root';

      Backbone.history.on('route', _.bind(function (app, route, args) {
        this.active = route;
        this.render();
      }, this));
    },

    templateHelpers: function () {
      return {
        activeClass: _.bind(function () {
          var routes;
          routes = arguments.length >= 1 ? slice.call(arguments, 0) : [];
          if (_.include(routes, this.active)) {
            return 'active';
          }
        }, this),
        accounts: _.bind(function () {
          return this.options.accounts;
        }, this)
      };
    },

    onRender: function () {
      // FIXME: This is yuck.
      var searchForm, searchModel;
      searchModel = new DotLedger.Models.QueryParams();
      searchForm = new DotLedger.Views.Search.NavForm({
        model: searchModel
      });
      this.ui.nav_search.html(searchForm.render().el);
    }
  });
});
