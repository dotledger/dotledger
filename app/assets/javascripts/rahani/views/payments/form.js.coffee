Rahani.module 'Views.Payments', ->
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
      new Rahani.Helpers.FormErrors(@model, @$el)
      @options.categories.on 'all', =>
        @renderCategories()

      _.each RahaniData.payment_types, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.type.append($option)

      _.each RahaniData.payment_periods, (option)=>
        $option = $("<option value='#{option}'>#{option}(s)</option>")
        @ui.repeat_period.append($option)

      @ui.name.val(@model.escape('name'))
      @ui.amount.val(@model.escape('amount'))
      @ui.date.val(@model.escape('date'))
      @ui.repeat.prop('checked', @model.get('repeat'))
      @ui.repeat_interval.val(@model.escape('repeat_interval'))
      @ui.repeat_period.val(@model.escape('repeat_period'))
      @ui.type.val(@model.escape('type'))
      @renderCategories()
      @toggleRepeat()

    renderCategories: ->
      @ui.category.empty()
      _.each @options.categories.groupBy('type'), (categories, label) =>
        $optgroup = $("<optgroup label='#{label}'></optgroup>")
        _.each categories, (category) =>
          $option = $("<option value='#{category.get('id')}'>#{category.get('name')}</option>")
          $optgroup.append($option)
        @ui.category.append($optgroup)

      @ui.category.val(@model.escape('category_id'))

    events:
      'click button.save': 'save'
      'submit form': 'save'
      'change input[name=repeat]': 'toggleRepeat'

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
