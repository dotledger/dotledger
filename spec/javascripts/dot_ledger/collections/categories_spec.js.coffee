describe "DotLedger.Collections.Categories", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Categories).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Categories::url).toEqual('/api/categories')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Categories::model).toEqual(DotLedger.Models.Category)
