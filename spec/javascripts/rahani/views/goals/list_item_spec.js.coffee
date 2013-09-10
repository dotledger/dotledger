describe "Rahani.Views.Goals.ListItem", ->

  createView = ->
    model = new Rahani.Models.Goal
      id: 1
      amount: "1000.0"
      period: "Month"
      category_id: 1 
      category_name: "Cash Withdrawals"
      category_type: "Flexible"
      
    new Rahani.Views.Goals.ListItem(model: model)

  it "should be defined", ->
    expect(Rahani.Views.Goals.ListItem).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.Goals.ListItem).toUseTemplate('goals/list_item')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the amount field", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=amount]')

  it "renders the period select", ->
    view = createView().render()
    expect(view.$el).toContain('select[name=period]')

  it "renders the category name", ->
    view = createView().render()
    expect(view.$el).toContainText('Cash Withdrawals')
