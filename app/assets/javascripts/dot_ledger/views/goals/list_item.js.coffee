DotLedger.module 'Views.Goals', ->
  class @ListItem extends Backbone.Marionette.ItemView
    tagName: 'div'
    className: 'list-group-item'
    template: 'goals/list_item'

    ui:
      amount: 'input[name=amount]'
      period: 'select[name=period]'

    initialize: ->
      @hasChanged = false

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      DotLedger.on 'options:change', @renderGoalPeriods, this

      @ui.amount.val(@model.get('amount'))

      @renderGoalPeriods()

    renderGoalPeriods: (data = DotLedgerData)->
      @ui.period.empty()
      _.each data.goal_periods, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.period.append($option)
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

      if @model.hasChanged()
        @hasChanged = true

    save: ->
      @update()

      if @hasChanged
        @model.save {},
          success: =>
            @hasChanged = false
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
