# Load app javascipt files

describe "_.compactObject", ->
  it "compacts objects", ->
    obj = {foo: "foo", bar: null, baz: undefined, blah: ""}
    result = {foo: "foo"}

    expect(_.compactObject(obj)).toEqual(result)
