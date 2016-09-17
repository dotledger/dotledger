describe "DotLedger.Models.AccountGroup", ->
  it "should be defined", ->
    expect(DotLedger.Models.AccountGroup).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.AccountGroup::urlRoot).toEqual('/api/account_groups')
