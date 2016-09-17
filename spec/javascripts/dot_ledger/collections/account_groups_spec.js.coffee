describe "DotLedger.Collections.AccountGroups", ->
  it "should be defined", ->
    expect(DotLedger.Collections.AccountGroups).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.AccountGroups::url).toEqual('/api/account_groups')

  it "should use the correct model", ->
    expect(DotLedger.Collections.AccountGroups::model).toEqual(DotLedger.Models.AccountGroup)
