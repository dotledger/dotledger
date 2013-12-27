describe "DotLedger.Views.Application.MainNav", ->
  createView = ->
    new DotLedger.Views.Application.MainNav(
      accounts: new Backbone.Collection
    )

  it "should be defined", ->
    expect(DotLedger.Views.Application.MainNav).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Application.MainNav).toUseTemplate('application/main_nav')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
