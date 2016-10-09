#= require_self
#= require ./helpers
#= require ./templates
#= require ./routers
#= require ./models
#= require ./collections
#= require ./behaviors
#= require ./regions
#= require ./views
#= require ./initializers

@DotLedgerData = {}
@DotLedger = new Marionette.Application()

DotLedger.title = (title_parts...)->
  DotLedger.trigger 'document:title', title_parts

Backbone.Marionette.Renderer.render = (template, data)->
  JST["dot_ledger/templates/#{template}"](data)

Marionette.Behaviors.behaviorsLookup = ->
  DotLedger.Behaviors

DotLedger.addRegions
  headerRegion: "header",
  notificationsRegion: "#notifications",
  mainRegion: "#main"
  footerRegion: "footer"
