DotLedger.addInitializer ->
  $('body').on 'click', 'a[href]', (e)->
    href = $(this).attr('href')

    if href.match(/^\/.*/) || href == '/'
      Backbone.history.navigate(href, trigger: true)
      e.preventDefault()
