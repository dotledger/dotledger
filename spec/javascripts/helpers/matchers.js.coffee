beforeEach ->
  jasmine.addMatchers
    toUseTemplate: (util, customEqualityTesters)->
      compare: (actual, expected)->
        templateExists = _.has JST, "dot_ledger/templates/#{expected}"
        templateSetCorrectly = actual::template == expected

        pass: templateExists && templateSetCorrectly
