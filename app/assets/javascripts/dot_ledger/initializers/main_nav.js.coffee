DotLedger.addInitializer (options)->
  @accounts = new DotLedger.Collections.Accounts()
  @accounts.fetch()
  @nav = new DotLedger.Views.Application.MainNav(
    accounts: @accounts
  )

  DotLedger.headerRegion.show(@nav)
