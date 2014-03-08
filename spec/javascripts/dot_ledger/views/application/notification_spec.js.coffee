describe "DotLedger.Views.Application.Notification", ->
  createView = (model = new Backbone.Model(message: 'Test'))->
    new DotLedger.Views.Application.Notification(model: model)

  it "should be defined", ->
    expect(DotLedger.Views.Application.Notification).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Application.Notification).toUseTemplate('application/notification')

  it "can be rendered", ->
    view = createView()

    expect(view.render).not.toThrow()

  it "should be removed when the close button is clicked", ->
    spyOn(DotLedger.Views.Application.Notification::, 'remove')

    view = createView()

    view.render()

    view.ui.close.click()

    expect(view.remove).toHaveBeenCalled()

  it "renders the message", ->
    model = new Backbone.Model(message: 'Hello, World!')

    view = createView(model)

    view.render()

    expect(view.$el).toContainText('Hello, World!')
