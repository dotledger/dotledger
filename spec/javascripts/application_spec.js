describe('_.compactObject', function () {
  it('compacts objects', function () {
    var obj, result;
    obj = {
      foo: 'foo',
      bar: null,
      baz: void 0,
      blah: '',
      number: 1
    };
    result = {
      foo: 'foo',
      number: 1
    };
    expect(_.compactObject(obj)).toEqual(result);
  });
});

describe('_.parseQueryString', function () {
  it('parses a query string', function () {
    var queryString, result;
    queryString = 'foo=bar&bar=1&bar=baz';
    result = {
      foo: 'bar',
      bar: ['1', 'baz']
    };
    expect(_.parseQueryString(queryString)).toEqual(result);
  });
});
