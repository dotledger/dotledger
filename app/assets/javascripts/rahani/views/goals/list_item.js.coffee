Rahani.module 'Views.Goals', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'div'
    className: 'list-group-item'
    template: 'goals/list_item'

    ui:
      amount: 'input[name=amount]'
      period: 'select[name=period]'

    onRender: ->
      new Rahani.Helpers.FormErrors(@model, @$el)
      _.each RahaniData.goal_periods, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.period.append($option)

      @ui.amount.val(@model.escape('amount'))
      @ui.period.val(@model.escape('period'))

    events:
      'click button.save': 'save'
      'submit form': 'save'

    update: ->
      data =
        amount: @ui.amount.val()
        period: @ui.period.val()

      @model.set(data)

    save: ->
      @update()

      if @model.hasChanged()
        @model.save {},
        success: =>
          @trigger 'save', @model

      false
