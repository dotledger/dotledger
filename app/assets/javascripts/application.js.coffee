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
#= require accounting
#= require underscore
#= require underscore.string
#= require backbone
#= require backbone.babysitter
#= require backbone.wreqr
#= require backbone.marionette
#= require jsurl
#= require dot_ledger

_.mixin compactObject: (object) ->
  _.each object, (v, k) ->
    delete object[k] if _.isEmpty(object[k])
  object
