Rahani.module 'Views.Statements', ->
  class @Form extends Backbone.Marionette.ItemView
    template: 'statements/form'

    ui:
      file: 'input[name=file]'

    events:
      'click button.save': 'save'
      'submit form': 'save'

    onRender: ->
      new Rahani.Helpers.FormErrors(@model, @$el)

    templateHelpers: ->
      accountName: @options.account.escape('name')
      accountId: @options.account.get('id')

    save: ->
      # FIXME: this is a bit hacky

      data = new FormData()
      files = @ui.file[0].files
      if files.length > 0
        data.append('file', files[0])
      data.append('account_id', @options.account.get('id'))

      $.ajax
        url: '/api/statements'
        data: data
        cache: false
        contentType: false
        processData: false
        type: 'POST'
        success: =>
          @trigger 'save'

        error: (resp)=>
          if resp.status == 422
            errors = JSON.parse(resp.responseText).errors
            @model.validationError = errors
            @model.trigger "invalid", @model, errors, {validationError: errors}

      false
