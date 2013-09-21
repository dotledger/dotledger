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

      @ui.amount.val(@model.get('amount'))
      @ui.period.val(@model.get('period'))

    events:
      'click button.save': 'save'
      'submit form': 'save'
      'change input': 'reRender'
      'change select': 'reRender'

    reRender: ->
      @update()
      @render()

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
    templateHelpers: ->
      monthAmount: =>
        amount = switch @model.get('period')
          when 'Month'
            1 * @model.get('amount')
          when 'Fortnight'
            1 * @model.get('amount') * 13.0/6
          when 'Week'
            1 * @model.get('amount') * 13.0/3

        accounting.formatMoney(amount)
