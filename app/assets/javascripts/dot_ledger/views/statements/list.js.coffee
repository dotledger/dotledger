DotLedger.module 'Views.Statements', ->
  class @List extends Backbone.Marionette.CompositeView
    template: 'statements/list'

    getChildView: -> DotLedger.Views.Statements.ListItem

    childViewContainer: 'table tbody'

    initialize: ->
      DotLedger.Helpers.pagination(this, @collection)

    templateHelpers: ->
      accountName: =>
        @options.account.get('name')

      accountID: =>
        @options.account.get('id')
