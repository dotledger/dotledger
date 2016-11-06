// = require_self
// = require ./app

DotLedger.module('Routers', function () {
  this.Base = Backbone.Marionette.AppRouter.extend({
    execute: function (callback, args, name) {
      var params;
      params = _.parseQueryString(args.pop());
      this.QueryParams = new DotLedger.Models.QueryParams(params);
      args.push(params);
      if (callback != null) {
        callback.apply(this, args);
      }
    }
  });
});
