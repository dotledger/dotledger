Rahani.module 'Helpers', ->
  @FormErrors = (model, $el) ->
    @model = model
    @$el = $el
    _.bindAll this, "processInvalid"
    @listenTo @model, "invalid", @processInvalid

  _.extend @FormErrors::, Backbone.Events,
    processInvalid: (model, errors, options) ->
      @showErrors errors

    showErrors: (errors) ->
      @removeErrors()
      _.each errors, ((error_messages, field) ->
        @showError field, error_messages
      ), this

    showError: (attribute, errors) ->
      $error_messages = $('<span class="server-side-error help-block" />').html(_.string.toSentence(errors))
      $form_group = @$el.find("[name='#{attribute}']").parents(".form-group")
      $form_group.addClass "has-error"
      $errors_container = $form_group.find('.errors')
      $errors_container.append($error_messages)

    removeErrors: ->
      @$el.find('.has-error').removeClass('has-error')
      @$el.find('.server-side-error').remove()
