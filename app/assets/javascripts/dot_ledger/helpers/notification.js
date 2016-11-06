DotLedger.module('Helpers', function () {
  var notificationView = function (message, className) {
    var model = new Backbone.Model({
      message: message
    });

    return new DotLedger.Views.Application.Notification({
      model: model,
      className: 'alert alert-' + className + ' alert-dismissable'
    });
  };

  this.Notification = {
    levels: ['danger', 'success', 'info', 'warning'],
    empty: this.app.notificationsRegion.empty
  };

  var notificationsRegion = this.app.notificationsRegion;

  _.each(this.Notification.levels, function (level) {
    this.Notification[level] = function (message) {
      var view = notificationView(message, level);
      notificationsRegion.show(view);
      window.scroll(0, 0);
    };
  }, this);
});
