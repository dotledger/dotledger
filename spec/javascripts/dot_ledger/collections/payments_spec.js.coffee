describe "DotLedger.Collections.Payments", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Payments).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Payments::url).toEqual('/api/payments')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Payments::model).toEqual(DotLedger.Models.Payment)
