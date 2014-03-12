DotLedger.module 'Views.Payments', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'payments/form'

    ui:
      name: 'input[name=name]'
      amount: 'input[name=amount]'
      category: 'select[name=category]'
      date: 'input[name=date]'
      repeat: 'input[name=repeat]'
      repeat_interval: 'input[name=repeat_interval]'
      repeat_period: 'select[name=repeat_period]'
      type: 'select[name=type]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      @options.categories.on 'all', =>
        @renderCategories()

      DotLedger.on 'options:change', @renderPaymentTypes, this
      DotLedger.on 'options:change', @renderPaymentPeriods, this

      @ui.name.val(@model.get('name'))
      @ui.amount.val(@model.get('amount'))
      @ui.date.val(@model.get('date'))
      @ui.date.datepicker(format: 'yyyy-mm-dd')
      @ui.repeat.prop('checked', @model.get('repeat'))
      @ui.repeat_interval.val(@model.get('repeat_interval'))
      @ui.repeat_period.val(@model.get('repeat_period'))

      @renderPaymentTypes()
      @renderPaymentPeriods()
      @renderCategories()
      @toggleRepeat()

    renderPaymentTypes: (data = DotLedgerData)->
      @ui.type.empty()
      _.each data.payment_types, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.type.append($option)
      @ui.type.val(@model.get('type'))

    renderPaymentPeriods: (data = DotLedgerData)->
      @ui.repeat_period.empty()
      _.each data.payment_periods, (option)=>
        $option = $("<option value='#{option}'>#{option}(s)</option>")
        @ui.repeat_period.append($option)
      @ui.repeat_period.val(@model.get('repeat_period'))

    renderCategories: ->
      @ui.category.empty()
      _.each @options.categories.groupBy('type'), (categories, label) =>
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) =>
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        @ui.category.append($optgroup)

      @ui.category.val(@model.get('category_id'))

    events:
      'click button.save': 'save'
      'submit form': 'save'
      'change input[name=repeat]': 'toggleRepeat'

    templateHelpers: ->
      pageHeader: =>
        if @model.has('name')
          @model.get('name')
        else
          'New Payment'

    toggleRepeat: ->
      if @ui.repeat.prop('checked')
        @ui.repeat_period.parents('.form-group').show()
        @ui.repeat_interval.parents('.form-group').show()
      else
        @ui.repeat_period.parents('.form-group').hide()
        @ui.repeat_interval.parents('.form-group').hide()

    update: ->
      data =
        name: @ui.name.val()
        amount: @ui.amount.val()
        category_id: @ui.category.val()
        date: @ui.date.val()
        repeat: @ui.repeat.prop('checked')
        repeat_interval: @ui.repeat_interval.val()
        repeat_period: @ui.repeat_period.val()
        type: @ui.type.val()

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          @trigger 'save', @model

      false
