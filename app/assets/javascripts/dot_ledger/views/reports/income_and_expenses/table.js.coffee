DotLedger.module 'Views.Reports.IncomeAndExpenses', ->
  class @Table extends Backbone.Marionette.CompositeView
    template: 'reports/income_and_expenses/table'

    getChildView: -> DotLedger.Views.Reports.IncomeAndExpenses.TableRow

    childViewContainer: "tbody"

    templateHelpers: ->
      spentAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_spent)
      receivedAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_received)
