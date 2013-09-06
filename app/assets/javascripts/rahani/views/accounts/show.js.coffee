Rahani.module 'Views.Accounts', ->
  class @Show extends Backbone.Marionette.Layout
    template: 'accounts/show'
    regions:
      sortedTransactions: '#sorted-transactions'
      unsortedTransactions: '#unsorted-transactions'
    onRender: ->
      @$el.find('#sorted-transactions').addClass('active')
      @$el.find('a[href="#sorted-transactions"]').parent().addClass('active')
