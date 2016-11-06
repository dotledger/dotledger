DotLedger.addInitializer(function () {
  $('body').on('click', 'a[href]', function (e) {
    var href = $(this).attr('href');

    if (href.match(/^\/.*/) || href === '/') {
      Backbone.history.navigate(href, {
        trigger: true
      });

      e.preventDefault();
    }
  });
});
