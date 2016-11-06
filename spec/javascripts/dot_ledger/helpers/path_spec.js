describe('DotLedger.Helpers.Path', function () {
  var namedMatchRoute, wildcardRoute;
  namedMatchRoute = 'foo/:id/bar/:something/baz';
  wildcardRoute = '*path';

  describe('.routeToPathHelper', function () {
    it('returns a function', function () {
      expect(DotLedger.Helpers.Path.routeToPathHelper(namedMatchRoute)).toEqual(jasmine.any(Function));
    });

    it('replaces named matches', function () {
      var fn;
      fn = DotLedger.Helpers.Path.routeToPathHelper(namedMatchRoute);
      expect(fn({
        id: 1,
        something: 'test'
      })).toEqual('/foo/1/bar/test/baz');
    });

    it('replaces wildcard matches', function () {
      var fn;
      fn = DotLedger.Helpers.Path.routeToPathHelper(wildcardRoute);
      expect(fn({
        path: 'something'
      })).toEqual('/something');
    });

    it('appends extra params as a query string', function () {
      var fn;
      fn = DotLedger.Helpers.Path.routeToPathHelper(namedMatchRoute);
      expect(fn({
        id: 1,
        something: 'test',
        blah: 'test',
        foo: 'bar'
      })).toEqual('/foo/1/bar/test/baz?blah=test&foo=bar');
    });
  });
});
