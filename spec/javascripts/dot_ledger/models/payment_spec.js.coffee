describe "DotLedger.Models.Payment", ->
  it "should be defined", ->
    expect(DotLedger.Models.Payment).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Payment::urlRoot).toEqual('/api/payments')
