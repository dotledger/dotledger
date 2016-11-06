DotLedger.module('Helpers', function () {
  this.Loading = {
    start: function () {
      DotLedger.container.addClass('loading');
    },

    stop: function () {
      DotLedger.container.removeClass('loading');
    }
  };
});
