describe('DotLedger.Helpers.Search', function () {
  var tests = [
    {
      input: {},
      output: ""
    },
    {
      input: { query: "pizza" },
      output: "query=pizza"
    },
    {
      input: { category_id: 12 },
      output: "category_id=12"
    },
    {
      input: { category_id: -1 },
      output: "unsorted=true"
    },
    {
      input: {
        actual_date_from: "2016-01-01T00:00:00.000+00:00",
        actual_date_to: "2016-12-31T23:59:59.000+00:00"
      },
      output: "date_from=2016-01-01&date_to=2016-12-31"
    },
    {
      input: {
        actual_date_from: "2016-01-01T00:00:00.000+13:00",
        actual_date_to: "2016-12-31T23:59:59.000+13:00"
      },
      output: "date_from=2016-01-01&date_to=2016-12-31"
    },
    {
      input: { tag_ids: [2] },
      output: "tag_ids=2"
    },
  ];


  _.each(tests, function (test) {
    it('correctly formats the "' + JSON.stringify(test.input) + '" into "' + test.output + '"', function () {
      expect(DotLedger.Helpers.Search(test.input).toString()).toEqual(test.output);
    });
  });
});