describe "Rahani.Views.Application.Dashboard", ->
  createView = ->
    new Rahani.Views.Application.Dashboard()

  it "should be defined", ->
    expect(Rahani.Views.Application.Dashboard).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Application.Dashboard).toUseTemplate('application/dashboard')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()
