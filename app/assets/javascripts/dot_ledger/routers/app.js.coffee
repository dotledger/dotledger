DotLedger.module 'Routers', ->
  routes =
    # Root
    '': 'root'

    # Accounts
    'accounts/new': 'newAccount'
    'accounts/:id/sort': 'sortAccount'
    'accounts/:id/edit': 'editAccount'
    'accounts/:id/import': 'newStatement'
    'accounts/:id/statements': 'listStatements'
    'accounts/:id': 'showAccount'

    # Categories
    'categories': 'listCategories'
    'categories/new': 'newCategory'
    'categories/:id/edit': 'editCategory'

    # Sorting Rules
    'sorting-rules/new': 'newSortingRule'
    'sorting-rules/:id/edit': 'editSortingRule'
    'sorting-rules': 'listSortingRules'

    # Goals
    'goals': 'listGoals'

    # Payments
    'payments': 'listPayments'
    'payments/new': 'newPayment'
    'payments/:id/edit': 'editPayment'

    # Account Groups
    'account-groups/new': 'newAccountGroup'
    'account-groups/:id/edit': 'editAccountGroup'
    'account-groups': 'listAccountGroups'

    # Search
    'search': 'search'

    # Reports
    'reports/income-and-expenses': 'incomeAndExpenses'

    # Not Found
    '*path': 'notFound'

  DotLedger.path = DotLedger.Helpers.Path.routesToPathHelpers(routes)
  DotLedger.navigate = DotLedger.Helpers.Path.routesToNavigateHelpers(routes)

  class @App extends @Base
    routes: routes

    root: ->
      DotLedger.title 'Dashboard'

      dashboard = new DotLedger.Views.Application.Dashboard()

      DotLedger.mainRegion.show(dashboard)

      category_statistics = new (DotLedger.Collections.Base.extend({
        url: '/api/statistics/activity_per_category'
      }))

      category_statistics.fetch
        success: ->
          activity = new DotLedger.Views.Statistics.ActivityPerCategory.List(
            collection: category_statistics
          )
          dashboard.panelC.show(activity)

      category_type_statistics = new (DotLedger.Collections.Base.extend({
        url: '/api/statistics/activity_per_category_type'
      }))

      category_type_statistics.fetch
        success: ->
          activity = new DotLedger.Views.Statistics.ActivityPerCategoryType.List(
            collection: category_type_statistics
          )
          dashboard.panelB.show(activity)

      accounts = new DotLedger.Collections.Accounts()
      accounts.fetch
        success: ->
          accounts_list = new DotLedger.Views.Accounts.List(collection: accounts)
          dashboard.panelA.show(accounts_list)

    notFound: (path)->
      model = new DotLedger.Models.Base
        path: path
      notFoundView = new DotLedger.Views.Application.NotFound
        model: model
      DotLedger.mainRegion.show(notFoundView)

    showAccount: (account_id)->
      @QueryParams.set(tab: 'sorted') unless @QueryParams.has('tab')
      @QueryParams.set(page: 1) unless @QueryParams.has('page')

      account = new DotLedger.Models.Account(id: account_id)
      transactions = new DotLedger.Collections.Transactions()

      DotLedger.navigate.showAccount(_.extend(id: account_id, @QueryParams.attributes), replace: true)

      transactions.on 'page:change', (page)=>
        @QueryParams.set(page: page)

      updateTransactions = =>
        switch @QueryParams.get('tab')
          when 'sorted'
            transactions.fetch
              data:
                account_id: account_id
                sorted: true
                review: false
                page: @QueryParams.get('page')

          when 'review'
            transactions.fetch
              data:
                account_id: account_id
                review: true
                page: @QueryParams.get('page')

          when 'unsorted'
            transactions.fetch
              data:
                account_id: account_id
                unsorted: true
                page: @QueryParams.get('page')

      @QueryParams.on 'change', =>
        DotLedger.navigate.showAccount(_.extend(id: account_id, @QueryParams.attributes))
        updateTransactions()

      updateTransactions()

      show = new DotLedger.Views.Accounts.Show
        params: @QueryParams
        model: account

      balanceGraph = new DotLedger.Views.Accounts.BalanceGraph
        model: account
        days: 90

      account.fetch
        success: ->
          DotLedger.title 'Accounts', account.get('name')

          transactionsTableView = new DotLedger.Views.Transactions.Table(
            collection: transactions
          )

          DotLedger.mainRegion.show(show)
          show.graph.show(balanceGraph)
          show.transactions.show(transactionsTableView)

    newAccount: ->
      account = new DotLedger.Models.Account()
      form = new DotLedger.Views.Accounts.Form(model: account)

      form.on 'save', (model)->
        DotLedger.navigate.showAccount({id: model.get('id')}, trigger: true)

      DotLedger.title 'New Account'

      DotLedger.mainRegion.show(form)

    sortAccount: (account_id)->
      $.ajax
        url: "/api/transactions/sort"
        data:
          account_id: account_id
        type: 'POST'
        success: (response)=>
          DotLedger.Helpers.Notification.success(response.message)
          DotLedger.Helpers.Loading.stop()
          @showAccount(account_id)

    editAccount: (account_id)->
      account = new DotLedger.Models.Account(id: account_id)
      form = new DotLedger.Views.Accounts.Form(model: account)

      account.fetch(
        success: ->
          DotLedger.title 'Edit Account', account.get('name')

          DotLedger.mainRegion.show(form)
      )

      form.on 'save', ->
        DotLedger.navigate.showAccount({id: account_id}, trigger: true)

    newStatement: (account_id)->
      account = new DotLedger.Models.Account(id: account_id)
      statement = new DotLedger.Models.Statement()
      form = new DotLedger.Views.Statements.Form(model: statement, account: account)

      account.fetch
        success: ->
          DotLedger.title 'New Statement', account.get('name')

          DotLedger.mainRegion.show(form)

      form.on 'save', ->
        DotLedger.navigate.showAccount({id: account_id}, trigger: true)

    listStatements: (account_id)->
      account = new DotLedger.Models.Account(id: account_id)
      statements = new DotLedger.Collections.Statements()
      list = new DotLedger.Views.Statements.List
        account: account
        collection: statements
      statements.fetch
        data:
          account_id: account_id

      account.fetch
        success: ->
          DotLedger.title 'Statements', account.get('name')

          DotLedger.mainRegion.show(list)

    listCategories: ->
      categories = new DotLedger.Collections.Categories()

      DotLedger.title 'Categories'

      categories.fetch
        success: ->
          list = new DotLedger.Views.Categories.List
            collection: categories

          DotLedger.mainRegion.show(list)

    newCategory: ->
      category = new DotLedger.Models.Category()
      form = new DotLedger.Views.Categories.Form(model: category)

      DotLedger.title 'New Category'

      form.on 'save', (model)->
        DotLedger.navigate.listCategories({}, trigger: true)

      DotLedger.mainRegion.show(form)

    editCategory: (category_id)->
      category = new DotLedger.Models.Category(id: category_id)
      form = new DotLedger.Views.Categories.Form(model: category)

      form.on 'save', (model)->
        DotLedger.navigate.listCategories({}, trigger: true)

      category.fetch
        success: ->
          DotLedger.title 'Edit Category', category.get('name')
          DotLedger.mainRegion.show(form)

    listSortingRules: ->
      @QueryParams.set(page: 1) unless @QueryParams.has('page')
      sorting_rules = new DotLedger.Collections.SortingRules()

      list = new DotLedger.Views.SortingRules.List
        collection: sorting_rules
        model: @QueryParams

      DotLedger.title 'Sorting Rules'

      updateSortingRules = =>
        DotLedger.navigate.listSortingRules(@QueryParams.attributes)
        sorting_rules.fetch(data: @QueryParams.attributes)

      list.on('search', updateSortingRules)

      updateSortingRules()

      DotLedger.mainRegion.show(list)

      sorting_rules.on 'page:change', (page)=>
        @QueryParams.set(page: page)
        DotLedger.navigate.listSortingRules(@QueryParams.attributes)

    newSortingRule: ->
      sorting_rule = new DotLedger.Models.SortingRule()

      DotLedger.title 'New Sorting Rule'

      form = new DotLedger.Views.SortingRules.Form
        model: sorting_rule

      form.on 'save', (model)->
        DotLedger.navigate.listSortingRules({}, trigger: true)
        DotLedger.Helpers.SortTransactions.sort()

      DotLedger.mainRegion.show(form)

    editSortingRule: (sorting_rule_id)->
      sorting_rule = new DotLedger.Models.SortingRule(id: sorting_rule_id)

      form = new DotLedger.Views.SortingRules.Form
        model: sorting_rule

      form.on 'save', (model)->
        DotLedger.navigate.listSortingRules({}, trigger: true)
        DotLedger.Helpers.SortTransactions.sort()

      sorting_rule.fetch
        success: ->
          DotLedger.title 'Edit Sorting Rule', sorting_rule.get('contains')

          DotLedger.mainRegion.show(form)

    listGoals: ->
      goals = new DotLedger.Collections.Goals()

      DotLedger.title 'Goals'

      goals.fetch
        success: ->
          list = new DotLedger.Views.Goals.List
            collection: goals

          DotLedger.mainRegion.show(list)

    listPayments: ->
      payments = new DotLedger.Collections.Payments()

      paymentsView = new DotLedger.Views.Payments.Payments()

      balanceGraph = new DotLedger.Views.Payments.ProjectedBalanceGraph
        days: 90

      list = new DotLedger.Views.Payments.List
        collection: payments

      DotLedger.title 'Payments'

      payments.fetch
        success: ->
          DotLedger.mainRegion.show(paymentsView)
          paymentsView.graph.show(balanceGraph)
          paymentsView.payments.show(list)

    newPayment: ->
      payment = new DotLedger.Models.Payment()

      DotLedger.title 'New Payment'

      form = new DotLedger.Views.Payments.Form
        model: payment

      form.on 'save', (model)->
        DotLedger.navigate.listPayments({}, trigger: true)

      DotLedger.mainRegion.show(form)

    editPayment: (payment_id)->
      payment = new DotLedger.Models.Payment(id: payment_id)

      form = new DotLedger.Views.Payments.Form
        model: payment

      payment.fetch(
        success: ->
          DotLedger.title 'Edit Payment', payment.get('name')

          DotLedger.mainRegion.show(form)
      )

      form.on 'save', ->
        DotLedger.navigate.listPayments({}, trigger: true)

    listAccountGroups: ->
      account_groups = new DotLedger.Collections.AccountGroups()

      DotLedger.title 'Account Groups'

      account_groups.fetch
        success: ->
          list = new DotLedger.Views.AccountGroups.List
            collection: account_groups

          DotLedger.mainRegion.show(list)

    newAccountGroup: ->
      account_group = new DotLedger.Models.AccountGroup()

      DotLedger.title 'New Account Group'

      form = new DotLedger.Views.AccountGroups.Form
        model: account_group

      form.on 'save', (model)->
        DotLedger.navigate.listAccountGroups({}, trigger: true)

      DotLedger.mainRegion.show(form)

    editAccountGroup: (account_group_id)->
      account_group = new DotLedger.Models.AccountGroup(id: account_group_id)

      form = new DotLedger.Views.AccountGroups.Form
        model: account_group

      account_group.fetch(
        success: ->
          DotLedger.title 'Edit Account Group', account_group.get('name')

          DotLedger.mainRegion.show(form)
      )

      form.on 'save', ->
        DotLedger.navigate.listAccountGroups({}, trigger: true)

    search: ->
      @QueryParams.set(page: 1) unless @QueryParams.has('page')

      searchLayout = new DotLedger.Views.Search.Search()

      searchFilters = new DotLedger.Views.Search.FilterForm
        model: @QueryParams

      transactions = new DotLedger.Collections.Transactions()

      transactions.on 'page:change', (page)=>
        @QueryParams.set(page: page)
        DotLedger.navigate.search(@QueryParams.attributes)

      searchSummary = new DotLedger.Views.Search.Summary(
        collection: transactions
      )

      updateTransactions = =>
        if @QueryParams.has('query')
          DotLedger.title 'Search', @QueryParams.get('query')
        else
          DotLedger.title 'Search'

        DotLedger.navigate.search(@QueryParams.attributes)
        transactions.fetch(data: @QueryParams.attributes)

      searchFilters.on('search', updateTransactions)

      updateTransactions()

      searchResults = new DotLedger.Views.Transactions.Table(
        collection: transactions
        showAccountName: true
      )

      DotLedger.mainRegion.show(searchLayout)
      searchLayout.searchFilters.show(searchFilters)
      searchLayout.searchSummary.show(searchSummary)
      searchLayout.searchResults.show(searchResults)

    incomeAndExpenses: ->
      DotLedger.title 'Reports', 'Income and Expenses'
      @QueryParams.set(period: 90) unless @QueryParams.has('period')

      DotLedger.navigate.incomeAndExpenses(@QueryParams.attributes, replace: true)

      filterView = new DotLedger.Views.Reports.IncomeAndExpenses.Filter
        model: @QueryParams

      reportView = new DotLedger.Views.Reports.IncomeAndExpenses.Show()

      category_statistics = new (DotLedger.Collections.Base.extend({
        url: '/api/statistics/activity_per_category'
      }))

      renderReport = =>
        DotLedger.navigate.incomeAndExpenses(@QueryParams.attributes)
        filterView.render()
        date_to = moment()
        period = @QueryParams.get('period')
        if period == 'mtd'
          date_from = moment().startOf('month')
        else
          date_from = moment().subtract('day', period)

        category_statistics.fetch
          data:
            date_to: date_to.format('YYYY-MM-DD')
            date_from: date_from.format('YYYY-MM-DD')
          success: ->
            activity = new DotLedger.Views.Reports.IncomeAndExpenses.Table(
              collection: category_statistics
            )
            reportView.report.show(activity)

      @QueryParams.on 'change:period', renderReport

      renderReport()
      DotLedger.mainRegion.show(reportView)
      reportView.filter.show(filterView)
