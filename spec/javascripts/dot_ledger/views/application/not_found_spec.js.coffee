describe "DotLedger.Views.Application.NotFound", ->
  createView = (model = new DotLedger.Models.Base(path: '/foo/bar'))->
    new DotLedger.Views.Application.NotFound
      model: model

  it "should be defined", ->
    expect(DotLedger.Views.Application.NotFound).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Application.NotFound).toUseTemplate('application/not_found')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the heading", ->
    view = createView().render()
    expect(view.$el).toContainText('Not Found')

  it "renders the path", ->
    view = createView().render()
    expect(view.$el).toContainText('/foo/bar')
