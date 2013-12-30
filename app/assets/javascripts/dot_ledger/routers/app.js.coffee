DotLedger.module 'Routers', ->
  class @App extends @Base
    routes:
      # Root
      '': 'root'

      # Accounts
      'accounts/new': 'newAccount'
      'accounts/:account_id/edit': 'editAccount'
      'accounts/:account_id/import': 'newStatement'
      'accounts/:account_id': 'showAccount'
      'accounts/:account_id/:tab': 'showAccount'

      # Categories
      'categories': 'listCategories'
      'categories/new': 'newCategory'
      'categories/:id/edit': 'editCategory'

      # Sorting Rules
      'sorting-rules': 'listSortingRules'
      'sorting-rules/new': 'newSortingRule'
      'sorting-rules/:id/edit': 'editSortingRule'

      # Goals
      'goals': 'listGoals'

      # Payments
      'payments': 'listPayments'
      'payments/new': 'newPayment'
      'payments/:id/edit': 'editPayment'

    root: ->
      dashboard = new DotLedger.Views.Application.Dashboard()

      DotLedger.mainRegion.show(dashboard)

      category_statistics = new (Backbone.Collection.extend({
        url: '/api/statistics/activity_per_category'
      }))

      category_statistics.fetch
        success: ->
          activity = new DotLedger.Views.Statistics.ActivityPerCategory.List(
            collection: category_statistics
          )
          dashboard.panelB.show(activity)

      accounts = new DotLedger.Collections.Accounts()
      accounts.fetch
        success: ->
          accounts_list = new DotLedger.Views.Accounts.List(collection: accounts)
          dashboard.panelA.show(accounts_list)

    showAccount: (account_id, tab = 'sorted')->
      account = new DotLedger.Models.Account(id: account_id)
      transactions = new DotLedger.Collections.Transactions()

      switch tab
        when 'sorted'
          transactions.fetch
            data:
              account_id: account_id
              sorted: true
              review: false

        when 'review'
          transactions.fetch
            data:
              account_id: account_id
              review: true

        when 'unsorted'
          transactions.fetch
            data:
              account_id: account_id
              unsorted: true

      show = new DotLedger.Views.Accounts.Show
        model: account
        tab: tab

      account.fetch
        success: ->

          DotLedger.mainRegion.show(show)

          transactionsTableView = new DotLedger.Views.Transactions.Table(
            collection: transactions
          )

          show.transactions.show(transactionsTableView)

    newAccount: ->
      account = new DotLedger.Models.Account()
      form = new DotLedger.Views.Accounts.Form(model: account)

      form.on 'save', (model)->
        Backbone.history.navigate("/accounts/#{model.get('id')}", trigger: true)

      DotLedger.mainRegion.show(form)

    editAccount: (account_id)->
      account = new DotLedger.Models.Account(id: account_id)
      form = new DotLedger.Views.Accounts.Form(model: account)

      account.fetch(
        success: ->
          DotLedger.mainRegion.show(form)
      )

      form.on 'save', ->
        Backbone.history.navigate("/accounts/#{account_id}", trigger: true)

    newStatement: (account_id)->
      account = new DotLedger.Models.Account(id: account_id)
      statement = new DotLedger.Models.Statement()
      form = new DotLedger.Views.Statements.Form(model: statement, account: account)

      account.fetch
        success: ->
          DotLedger.mainRegion.show(form)

      form.on 'save', ->
        Backbone.history.navigate("/accounts/#{account_id}", trigger: true)

    listCategories: ->
      categories = new DotLedger.Collections.Categories()
      categories.fetch
        success: ->
          list = new DotLedger.Views.Categories.List
            collection: categories

          DotLedger.mainRegion.show(list)

    newCategory: ->
      category = new DotLedger.Models.Category()
      form = new DotLedger.Views.Categories.Form(model: category)

      form.on 'save', (model)->
        Backbone.history.navigate("/categories", trigger: true)

      DotLedger.mainRegion.show(form)

    editCategory: (category_id)->
      category = new DotLedger.Models.Category(id: category_id)
      form = new DotLedger.Views.Categories.Form(model: category)

      form.on 'save', (model)->
        Backbone.history.navigate("/categories", trigger: true)

      category.fetch
        success: ->
          DotLedger.mainRegion.show(form)

    listSortingRules: ->
      sorting_rules = new DotLedger.Collections.SortingRules()
      sorting_rules.fetch
        success: ->
          list = new DotLedger.Views.SortingRules.List
            collection: sorting_rules

          DotLedger.mainRegion.show(list)

    newSortingRule: ->
      sorting_rule = new DotLedger.Models.SortingRule()
      categories = new DotLedger.Collections.Categories()

      categories.fetch()

      form = new DotLedger.Views.SortingRules.Form
        model: sorting_rule
        categories: categories

      form.on 'save', (model)->
        Backbone.history.navigate("/sorting-rules", trigger: true)

      DotLedger.mainRegion.show(form)

    editSortingRule: (sorting_rule_id)->
      sorting_rule = new DotLedger.Models.SortingRule(id: sorting_rule_id)
      categories = new DotLedger.Collections.Categories()

      categories.fetch()

      form = new DotLedger.Views.SortingRules.Form
        model: sorting_rule
        categories: categories

      form.on 'save', (model)->
        Backbone.history.navigate("/sorting-rules", trigger: true)

      sorting_rule.fetch
        success: ->
          DotLedger.mainRegion.show(form)

    listGoals: ->
      goals = new DotLedger.Collections.Goals()
      goals.fetch
        success: ->
          list = new DotLedger.Views.Goals.List
            collection: goals

          DotLedger.mainRegion.show(list)

    listPayments: ->
      payments = new DotLedger.Collections.Payments()
      payments.fetch
        success: ->
          list = new DotLedger.Views.Payments.List
            collection: payments

          DotLedger.mainRegion.show(list)

    newPayment: ->
      payment = new DotLedger.Models.Payment()
      categories = new DotLedger.Collections.Categories()

      categories.fetch()

      form = new DotLedger.Views.Payments.Form
        model: payment
        categories: categories

      form.on 'save', (model)->
        Backbone.history.navigate("/payments", trigger: true)

      DotLedger.mainRegion.show(form)

    editPayment: (payment_id)->
      payment = new DotLedger.Models.Payment(id: payment_id)
      categories = new DotLedger.Collections.Categories()

      categories.fetch()

      form = new DotLedger.Views.Payments.Form
        model: payment
        categories: categories

      payment.fetch(
        success: ->
          DotLedger.mainRegion.show(form)
      )

      form.on 'save', ->
        Backbone.history.navigate("/payments", trigger: true)
