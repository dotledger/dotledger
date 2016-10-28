DotLedger.module 'Helpers', ->
  @SortTransactions =
    sort: (account_id)->
      data = {}
      if account_id
        data.account_id = account_id

      $.ajax
        url: "/api/transactions/sort"
        type: 'POST'
        data: data
        success: (response)->
          DotLedger.Helpers.Notification.success(response.message)
          DotLedger.Helpers.Loading.stop()