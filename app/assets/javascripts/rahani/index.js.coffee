#= require_self
#= require ./helpers
#= require_tree ./templates
#= require ./routers
#= require ./models
#= require ./collections
#= require_tree ./regions
#= require_tree ./views
#= require_tree ./initializers

# Add `loading` class to the body if ajax requests take longer than 150ms

@Rahani = new Marionette.Application()

Backbone.Marionette.Renderer.render = (template, data)->
  JST["rahani/templates/#{template}"](data)

Rahani.addRegions
  headerRegion: "header",
  mainRegion: "#main"
  footerRegion: "footer"
