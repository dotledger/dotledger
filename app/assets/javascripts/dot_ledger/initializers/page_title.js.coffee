DotLedger.addInitializer ->

  initial_title = $('title').text()

  DotLedger.on 'document:title', (title_parts)->

    title_parts.push(initial_title)

    title = title_parts.join(' &middot; ')

    $('title').html(title)
