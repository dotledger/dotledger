Rahani.module 'Views.Accounts', ->
  class @Show extends Backbone.Marionette.CompositeView
    template: 'accounts/show'
    getItemView: -> Rahani.Views.Transactions.TableRow
    itemViewContainer: 'tbody'
