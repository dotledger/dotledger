describe "DotLedger.Views.Application.Dashboard", ->
  createView = ->
    new DotLedger.Views.Application.Dashboard()

  it "should be defined", ->
    expect(DotLedger.Views.Application.Dashboard).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Application.Dashboard).toUseTemplate('application/dashboard')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
