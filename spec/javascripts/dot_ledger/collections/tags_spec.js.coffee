describe "DotLedger.Collections.Tags", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Tags).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Tags::url).toEqual('/api/tags')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Tags::model).toEqual(DotLedger.Models.Tag)
