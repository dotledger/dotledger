DotLedger.addInitializer(function () {
  var initialTitle;
  initialTitle = $('title').text();

  DotLedger.on('document:title', function (titleParts) {
    var title;
    titleParts.push(initialTitle);
    title = titleParts.join(' &middot; ');
    $('title').html(title);
  });
});
