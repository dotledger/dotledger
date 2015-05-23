# Load app javascipt files

describe "_.compactObject", ->
  it "compacts objects", ->
    obj = {foo: "foo", bar: null, baz: undefined, blah: "", number: 1}
    result = {foo: "foo", number: 1}

    expect(_.compactObject(obj)).toEqual(result)

describe "_.parseQueryString", ->
  it "parses a query string", ->
    queryString = "foo=bar&bar=1&bar=baz"
    result = {foo: "bar", bar: ["1", "baz"]}

    expect(_.parseQueryString(queryString)).toEqual(result)
