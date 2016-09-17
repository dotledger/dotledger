DotLedger.module 'Views.Accounts', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'accounts/form'

    behaviors:
      AccountGroupSelector:
        showAnyOption: false
        showNoneOption: true

    ui:
      name: 'input[name=name]'
      number: 'input[name=number]'
      type: 'select[name=type]'
      account_group: 'select[name=account_group]'

    onRender: ->
      new DotLedger.Helpers.FormErrors(@model, @$el)

      DotLedger.on 'options:change', @renderAccountTypes, this

      @ui.name.val(@model.get('name'))
      @ui.number.val(@model.get('number'))
      @renderAccountTypes()

    renderAccountTypes: (data = DotLedgerData)->
      @ui.type.empty()
      _.each data.account_types, (option)=>
        $option = $("<option value='#{option}'>#{option}</option>")
        @ui.type.append($option)
      @ui.type.val(@model.get('type'))

    events:
      'click button.save': 'save'
      'submit form': 'save'

    templateHelpers: ->
      pageHeader: =>
        if @model.has('name')
          @model.get('name')
        else
          'New Account'
      cancelPath: =>
        if @model.get('id')
          DotLedger.path.showAccount(id: @model.get('id'))
        else
          DotLedger.path.root()

    update: ->
      data =
        name: @ui.name.val()
        number: @ui.number.val()
        type: @ui.type.val()

      if @ui.account_group.val() > -1
        data['account_group_id'] = @ui.account_group.val()
      else
        data['account_group_id'] = null

      @model.set(data)

    save: ->
      @update()

      @model.save {},
        success: =>
          DotLedger.accounts.fetch()
          @trigger 'save', @model

      false
