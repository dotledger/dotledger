beforeEach ->
  @addMatchers
    toUseTemplate: (template) ->
      templateExists = _.has JST, "rahani/templates/#{template}"
      templateSetCorrectly = @actual::template == template
      return templateExists && templateSetCorrectly
