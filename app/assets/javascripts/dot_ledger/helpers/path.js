DotLedger.module('Helpers', function () {
  var namedParam;
  namedParam = /[:\*](\w+)/g;

  this.Path = {
    routesToNavigateHelpers: function (routes) {
      var helpers = {};

      _.each(routes, function (funcName, route) {
        var fn = DotLedger.Helpers.Path.routeToPathHelper(route);

        helpers[funcName] = function (args, navigateOptions) {
          args = (args || {});
          navigateOptions = (navigateOptions || {});

          Backbone.history.navigate(fn(args), navigateOptions);
        };
      });

      return helpers;
    },

    routesToPathHelpers: function (routes) {
      var helpers = {};

      _.each(routes, function (funcName, route) {
        helpers[funcName] = DotLedger.Helpers.Path.routeToPathHelper(route);
      });

      return helpers;
    },

    routeToPathHelper: function (route) {
      return function (args) {
        var matched, omitted, path;

        args = (args || {});

        matched = [];

        path = route.replace(namedParam, function (_, key) {
          if (args.hasOwnProperty(key)) {
            matched.push(key);
            return args[key];
          } else {
            return '';
          }
        });

        omitted = new DotLedger.Models.QueryParams(_.omit(args, matched));
        if (omitted.isEmpty()) {
          return '/' + path;
        } else {
          return '/' + path + '?' + omitted;
        }
      };
    }
  };
});
