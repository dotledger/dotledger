describe "DotLedger.Views.AccountGroups.ListItem", ->

  it "should be defined", ->
    expect(DotLedger.Views.AccountGroups.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.AccountGroups.ListItem).toUseTemplate('account_groups/list_item')
