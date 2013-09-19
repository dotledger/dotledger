Rahani.module 'Routers', ->
  class @App extends @Base
    routes:
      # Root
      '': 'root'

      # Accounts
      'accounts/new': 'newAccount'
      'accounts/:account_id': 'showAccount'
      'accounts/:account_id/edit': 'editAccount'
      'accounts/:account_id/import': 'newStatement'

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

    root: ->
      accounts = new Rahani.Collections.Accounts()
      dashboard = new Rahani.Views.Application.Dashboard()

      accounts.fetch
        success: ->
          accounts_list = new Rahani.Views.Accounts.List(collection: accounts)
          dashboard.panelA.show(accounts_list)

      Rahani.mainRegion.show(dashboard)

    showAccount: (account_id)->
      account = new Rahani.Models.Account(id: account_id)
      sortedTransactions = new Rahani.Collections.Transactions()
      reviewTransactions = new Rahani.Collections.Transactions()
      unsortedTransactions = new Rahani.Collections.Transactions()

      sortedTransactions.fetch
        data:
          account_id: account_id
          sorted: true
          review: false

      reviewTransactions.fetch
        data:
          account_id: account_id
          review: true

      unsortedTransactions.fetch
        data:
          account_id: account_id
          unsorted: true

      show = new Rahani.Views.Accounts.Show
        model: account

      account.fetch
        success: ->

          Rahani.mainRegion.show(show)

          sortedView = new Rahani.Views.Transactions.Table(
            collection: sortedTransactions
          )

          reviewView = new Rahani.Views.Transactions.Table(
            collection: reviewTransactions
          )

          unsortedView = new Rahani.Views.Transactions.Table(
            collection: unsortedTransactions
          )

          show.sortedTransactions.show(sortedView)
          show.reviewTransactions.show(reviewView)
          show.unsortedTransactions.show(unsortedView)

    newAccount: ->
      account = new Rahani.Models.Account()
      form = new Rahani.Views.Accounts.Form(model: account)

      form.on 'save', (model)->
        Backbone.history.navigate("/accounts/#{model.get('id')}", trigger: true)

      Rahani.mainRegion.show(form)

    editAccount: (account_id)->
      account = new Rahani.Models.Account(id: account_id)
      form = new Rahani.Views.Accounts.Form(model: account)

      account.fetch(
        success: ->
          Rahani.mainRegion.show(form)
      )

      form.on 'save', ->
        Backbone.history.navigate("/accounts/#{account_id}", trigger: true)

    newStatement: (account_id)->
      account = new Rahani.Models.Account(id: account_id)
      statement = new Rahani.Models.Statement()
      form = new Rahani.Views.Statements.Form(model: statement, account: account)

      account.fetch
        success: ->
          Rahani.mainRegion.show(form)

      form.on 'save', ->
        Backbone.history.navigate("/accounts/#{account_id}", trigger: true)

    listCategories: ->
      categories = new Rahani.Collections.Categories()
      categories.fetch
        success: ->
          list = new Rahani.Views.Categories.List
            collection: categories

          Rahani.mainRegion.show(list)

    newCategory: ->
      category = new Rahani.Models.Category()
      form = new Rahani.Views.Categories.Form(model: category)

      form.on 'save', (model)->
        Backbone.history.navigate("/categories", trigger: true)

      Rahani.mainRegion.show(form)

    editCategory: (category_id)->
      category = new Rahani.Models.Category(id: category_id)
      form = new Rahani.Views.Categories.Form(model: category)

      form.on 'save', (model)->
        Backbone.history.navigate("/categories", trigger: true)

      category.fetch
        success: ->
          Rahani.mainRegion.show(form)

    listSortingRules: ->
      sorting_rules = new Rahani.Collections.SortingRules()
      sorting_rules.fetch
        success: ->
          list = new Rahani.Views.SortingRules.List
            collection: sorting_rules

          Rahani.mainRegion.show(list)

    newSortingRule: ->
      sorting_rule = new Rahani.Models.SortingRule()
      categories = new Rahani.Collections.Categories()

      categories.fetch()

      form = new Rahani.Views.SortingRules.Form
        model: sorting_rule
        categories: categories

      form.on 'save', (model)->
        Backbone.history.navigate("/sorting-rules", trigger: true)

      Rahani.mainRegion.show(form)

    editSortingRule: (sorting_rule_id)->
      sorting_rule = new Rahani.Models.SortingRule(id: sorting_rule_id)
      categories = new Rahani.Collections.Categories()

      categories.fetch()

      form = new Rahani.Views.SortingRules.Form
        model: sorting_rule
        categories: categories

      form.on 'save', (model)->
        Backbone.history.navigate("/sorting-rules", trigger: true)

      sorting_rule.fetch
        success: ->
          Rahani.mainRegion.show(form)

    listGoals: ->
      goals = new Rahani.Collections.Goals()
      goals.fetch
        success: ->
          list = new Rahani.Views.Goals.List
            collection: goals

          Rahani.mainRegion.show(list)

    listPayments: ->
      payments = new Rahani.Collections.Payments()
      payments.fetch
        success: ->
          list = new Rahani.Views.Payments.List
            collection: payments

          Rahani.mainRegion.show(list)
