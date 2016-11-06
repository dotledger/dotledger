// = require_self
// = require ./helpers
// = require ./templates
// = require ./routers
// = require ./models
// = require ./collections
// = require ./behaviors
// = require ./regions
// = require ./views
// = require ./initializers

var slice = [].slice;

this.DotLedgerData = {};

this.DotLedger = new Marionette.Application();

DotLedger.title = function () {
  var titleParts;
  titleParts = arguments.length >= 1 ? slice.call(arguments, 0) : [];
  DotLedger.trigger('document:title', titleParts);
};

Backbone.Marionette.Renderer.render = function (template, data) {
  return JST['dot_ledger/templates/' + template](data);
};

Marionette.Behaviors.behaviorsLookup = function () {
  return DotLedger.Behaviors;
};

DotLedger.addRegions({
  headerRegion: 'header',
  notificationsRegion: '#notifications',
  mainRegion: '#main',
  footerRegion: 'footer'
});
