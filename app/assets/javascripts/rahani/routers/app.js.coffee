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
      transactions = new Rahani.Collections.Transactions()

      transactions.fetch
        data:
          account_id: account_id

      account.fetch
        success: ->
          show = new Rahani.Views.Accounts.Show
            model: account
            collection: transactions

          Rahani.mainRegion.show(show)

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
