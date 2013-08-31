describe "Rahani.Views.Application.MainNav", ->
  createView = ->
    new Rahani.Views.Application.MainNav(
      accounts: new Backbone.Collection
    )

  it "should be defined", ->
    expect(Rahani.Views.Application.MainNav).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Application.MainNav).toUseTemplate('application/main_nav')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
