describe "DotLedger.Views.Application.ConfirmationModal", ->
  createView = (options = {})->
    new DotLedger.Views.Application.ConfirmationModal(options)

  it "should be defined", ->
    expect(DotLedger.Views.Application.ConfirmationModal).toBeDefined()

  it "should use the correct template", ->
    expect(DotLedger.Views.Application.ConfirmationModal).toUseTemplate('application/confirmation_modal')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "should be destroyed when the close button is clicked", ->
    spyOn(DotLedger.Views.Application.ConfirmationModal::, 'destroy')

    view = createView()

    view.render()

    view.ui.close.click()

    expect(view.destroy).toHaveBeenCalled()

  it "should be destroyed when the cancel link is clicked", ->
    spyOn(DotLedger.Views.Application.ConfirmationModal::, 'destroy')

    view = createView()

    view.render()

    view.ui.cancel.click()

    expect(view.destroy).toHaveBeenCalled()

  it "should confirm when the confirm button is clicked", ->
    spyOn(DotLedger.Views.Application.ConfirmationModal::, 'confirm')

    view = createView()

    view.render()

    view.ui.confirm.click()

    expect(view.confirm).toHaveBeenCalled()

  it "renders the title", ->
    view = createView().render()
    expect(view.$el).toContainText('Are you sure?')

  it "renders the body", ->
    view = createView().render()
    expect(view.$el).toContainText('Are you sure you want to continue?')

  it "renders the confirm button", ->
    view = createView().render()
    expect(view.$el).toContainText('Confirm')
  
  it "renders the cancel link", ->
    view = createView().render()
    expect(view.$el).toContainText('Cancel')

  it "renders the custom title", ->
    view = createView(title: 'For real?').render()
    expect(view.$el).toContainText('For real?')

  it "renders the custom body", ->
    view = createView(body: 'WARNING!').render()
    expect(view.$el).toContainText('WARNING!')

  it "renders the custom confirm button", ->
    view = createView(confirm: 'YES!').render()
    expect(view.$el).toContainText('YES!')
  
  it "renders the custom cancel link", ->
    view = createView(cancel: 'No way!').render()
    expect(view.$el).toContainText('No way!')