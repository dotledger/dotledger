beforeEach(function () {
  return jasmine.addMatchers({
    toUseTemplate: function (util, customEqualityTesters) {
      return {
        compare: function (actual, expected) {
          var templateExists, templateSetCorrectly;
          templateExists = _.has(JST, 'dot_ledger/templates/' + expected);
          templateSetCorrectly = actual.prototype.template === expected;
          return {
            pass: templateExists && templateSetCorrectly
          };
        }
      };
    }
  });
});
