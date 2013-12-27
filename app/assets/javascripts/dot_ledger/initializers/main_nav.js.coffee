DotLedger.addInitializer (options)->
  @nav = new DotLedger.Views.Application.MainNav(
    accounts: new DotLedger.Collections.Accounts(options.accounts) 
  )
  DotLedger.headerRegion.show(@nav)
