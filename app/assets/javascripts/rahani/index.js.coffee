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
(->
  ajaxStarted = false;

  setOpacity = ->
    if ajaxStarted
      $('body').addClass 'loading'
    else
      $('body').removeClass 'loading'

  $(document).ajaxStart ->
    ajaxStarted = true
    _.delay(setOpacity, 150)

  $(document).ajaxStop ->
    ajaxStarted = false
    setOpacity()
)()

@Rahani = new Marionette.Application()

Backbone.Marionette.Renderer.render = (template, data)->
  JST["rahani/templates/#{template}"](data)

Rahani.addRegions
  headerRegion: "header",
  mainRegion: "#main"
  footerRegion: "footer"
