Rahani.addInitializer (options)->
  @nav = new Rahani.Views.Application.MainNav(
    accounts: new Rahani.Collections.Accounts(options.accounts) 
  )
  Rahani.headerRegion.show(@nav)
