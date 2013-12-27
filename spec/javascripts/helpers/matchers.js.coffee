beforeEach ->
  @addMatchers
    toUseTemplate: (template) ->
      templateExists = _.has JST, "dot_ledger/templates/#{template}"
      templateSetCorrectly = @actual::template == template
      return templateExists && templateSetCorrectly
