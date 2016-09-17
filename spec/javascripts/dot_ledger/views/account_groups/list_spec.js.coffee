describe "DotLedger.Views.AccountGroups.List", ->

  it "should be defined", ->
    expect(DotLedger.Views.AccountGroups.List).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.AccountGroups.List).toUseTemplate('account_groups/list')
