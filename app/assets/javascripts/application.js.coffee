#= require pace
#= require jquery
#= require bootstrap/button
#= require bootstrap/collapse
#= require bootstrap/dropdown
#= require bootstrap/modal
#= require bootstrap/tab
#= require bootstrap-datepicker
#= require jquery.flot
#= require jquery.flot.time
#= require moment
#= require underscore
#= require underscore.string
#= require backbone
#= require backbone.babysitter
#= require backbone.wreqr
#= require backbone.marionette
#= require dot_ledger

_.mixin
  compactObject: (object) ->
    _.each object, (v, k) ->
      delete object[k] if _.isEmpty(object[k]) and not _.isNumber(object[k])
    object

  parseQueryString: (queryString) ->
    return {} if typeof queryString != 'string' or queryString == ''
    variables = queryString.trim().replace(/\+/g, ' ').split('&')

    (pair.split '=' for pair in variables).reduce((output, pair) ->
      [key, value] = pair
      key = decodeURIComponent(key)
      value = if value? then decodeURIComponent(value) else null

      unless key of output
        output[key] = value
      else if _.isArray(output[key])
        output[key].push value
      else
        output[key] = [output[key], value]

      output
    , {})
