DotLedger.module 'Views.Reports.IncomeAndExpenses', ->
  class @Table extends Backbone.Marionette.CompositeView
    template: 'reports/income_and_expenses/table'

    getChildView: -> DotLedger.Views.Reports.IncomeAndExpenses.TableRow

    childViewOptions: (model, index)->
      {
        metadata: @collection.metadata
      }

    templateHelpers: ->
      spentAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_spent)
      receivedAmountTotal: =>
        DotLedger.Helpers.Format.money(@collection.metadata.total_received)
      spentAmountSubTotal: (label)=>
        amount = @collection.
          chain().
          select((row)-> row.get('type') == label).
          map((row)-> row.get('spent')).
          reduce(((total, amount)->  total + parseFloat(amount)), 0.0).
          value()
      
        DotLedger.Helpers.Format.money(amount)
    
      receivedAmountSubTotal: (label)=>
        amount = @collection.
          chain().
          select((row)-> row.get('type') == label).
          map((row)-> row.get('received')).
          reduce(((total, amount)->  total + parseFloat(amount)), 0.0).
          value()
      
        DotLedger.Helpers.Format.money(amount)
    
      categoryTypes: =>
        types = _.uniq(@collection.pluck('type'))
        _.map types, (type)->
          label: type
          id: "category-type-#{s.underscored(type)}"

    attachHtml: (collectionView, childView, index)->
      list_id =  "category-type-#{s.underscored(childView.model.get('type'))}"
      collectionView.$("##{list_id}").append(childView.el)
