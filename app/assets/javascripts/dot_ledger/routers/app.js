DotLedger.module('Routers', function () {
  var routes;
  routes = {
    // Root
    '': 'root',

    // Accounts
    'accounts': 'listAccounts',
    'accounts/new': 'newAccount',
    'accounts/:id/sort': 'sortAccount',
    'accounts/:id/edit': 'editAccount',
    'accounts/:id/import': 'newStatement',
    'accounts/:id/statements': 'listStatements',
    'accounts/:id': 'showAccount',

    // Categories
    'categories': 'listCategories',
    'categories/new': 'newCategory',
    'categories/:id/edit': 'editCategory',

    // Sorting Rules
    'sorting-rules/new': 'newSortingRule',
    'sorting-rules/:id/edit': 'editSortingRule',
    'sorting-rules': 'listSortingRules',

    // Goals
    'goals': 'listGoals',

    // Payments
    'payments': 'listPayments',
    'payments/new': 'newPayment',
    'payments/:id/edit': 'editPayment',

    // Account Groups
    'account-groups/new': 'newAccountGroup',
    'account-groups/:id/edit': 'editAccountGroup',
    'account-groups': 'listAccountGroups',


    // Saved Searches
    'saved-searches/new': 'newSavedSearch',
    'saved-searches/:id/edit': 'editSavedSearch',
    'saved-searches': 'listSavedSearches',

    // Search
    'search': 'search',

    // Reports
    'reports/income-and-expenses': 'incomeAndExpenses',

    // Not Found
    '*path': 'notFound'
  };

  DotLedger.path = DotLedger.Helpers.Path.routesToPathHelpers(routes);
  DotLedger.navigate = DotLedger.Helpers.Path.routesToNavigateHelpers(routes);

  this.App = this.Base.extend({
    routes: routes,

    root: function () {
      var accounts, categoryStatistics, categoryTypeStatistics, dashboard;
      DotLedger.title('Dashboard');
      dashboard = new DotLedger.Views.Application.Dashboard();

      DotLedger.mainRegion.show(dashboard);

      categoryStatistics = new (DotLedger.Collections.Base.extend({
        url: '/api/statistics/activity_per_category'
      }))();

      categoryStatistics.fetch({
        success: function () {
          var activity;
          activity = new DotLedger.Views.Statistics.ActivityPerCategory.List({
            collection: categoryStatistics
          });
          dashboard.panelC.show(activity);
        }
      });

      categoryTypeStatistics = new (DotLedger.Collections.Base.extend({
        url: '/api/statistics/activity_per_category_type'
      }))();

      categoryTypeStatistics.fetch({
        success: function () {
          var activity;
          activity = new DotLedger.Views.Statistics.ActivityPerCategoryType.List({
            collection: categoryTypeStatistics
          });
          dashboard.panelB.show(activity);
        }
      });

      accounts = new DotLedger.Collections.Accounts();
      accounts.fetch({
        success: function () {
          var accountsList;
          accountsList = new DotLedger.Views.Accounts.ListWidget({
            collection: accounts,
            isDashboard: true
          });

          dashboard.panelA.show(accountsList);
        }
      });
    },

    notFound: function (path) {
      var model, notFoundView;
      model = new DotLedger.Models.Base({
        path: path
      });

      notFoundView = new DotLedger.Views.Application.NotFound({
        model: model
      });
      DotLedger.mainRegion.show(notFoundView);
    },

    listAccounts: function () {
      var activeAccounts, archivedAccounts;
      DotLedger.title('Accounts');

      list = new DotLedger.Views.Accounts.List();
      DotLedger.mainRegion.show(list);

      activeAccounts = new DotLedger.Collections.Accounts();
      activeAccounts.fetch({
        success: function () {
          var listWidget;
          listWidget = new DotLedger.Views.Accounts.ListWidget({
            collection: activeAccounts,
            pageTitle: 'Active Accounts',
            isDashboard: false
          });
          list.activeAccounts.show(listWidget);
        }
      });

      archivedAccounts = new DotLedger.Collections.Accounts();
      archivedAccounts.fetch({
        data: {
          archived: true
        },
        success: function () {
          var listWidget;
          listWidget = new DotLedger.Views.Accounts.ListWidget({
            collection: archivedAccounts,
            pageTitle: 'Archived Accounts',
            isDashboard: false,
            childView: DotLedger.Views.Accounts.ListItemArchived
          });
          list.archivedAccounts.show(listWidget);
        }
      });
    },

    showAccount: function (accountID) {
      var account, balanceGraph, show, transactions, updateTransactions;

      if (!this.QueryParams.has('tab')) {
        this.QueryParams.set({
          tab: 'sorted'
        });
      }

      if (!this.QueryParams.has('page')) {
        this.QueryParams.set({
          page: 1
        });
      }

      if (!this.QueryParams.has('period')) {
        this.QueryParams.set({
          period: 90
        });
      }

      account = new DotLedger.Models.Account({
        id: accountID
      });

      transactions = new DotLedger.Collections.Transactions();

      DotLedger.navigate.showAccount(_.extend({
        id: accountID
      }, this.QueryParams.attributes), {
        replace: true
      });

      transactions.on('page:change', _.bind(function (page) {
        this.QueryParams.set({
          page: page
        });
      }, this));

      updateTransactions = _.bind(function () {
        switch (this.QueryParams.get('tab')) {
          case 'sorted':
            transactions.fetch({
              data: {
                account_id: accountID,
                sorted: true,
                review: false,
                page: this.QueryParams.get('page')
              }
            });
            break;
          case 'review':
            transactions.fetch({
              data: {
                account_id: accountID,
                review: true,
                page: this.QueryParams.get('page')
              }
            });
            break;
          case 'unsorted':
            transactions.fetch({
              data: {
                account_id: accountID,
                unsorted: true,
                page: this.QueryParams.get('page')
              }
            });
            break;
        }
      }, this);

      this.QueryParams.on('change', _.bind(function () {
        DotLedger.navigate.showAccount(_.extend({
          id: accountID
        }, this.QueryParams.attributes));
        updateTransactions();
      }, this));

      updateTransactions();

      show = new DotLedger.Views.Accounts.Show({
        params: this.QueryParams,
        model: account
      });

      balanceGraph = new DotLedger.Views.Accounts.BalanceGraph({
        params: this.QueryParams,
        model: account
      });

      this.QueryParams.on('change:period', show.fetchBalances);

      account.fetch({
        success: function () {
          var transactionsTableView;
          DotLedger.title('Accounts', account.get('name'));
          transactionsTableView = new DotLedger.Views.Transactions.Table({
            collection: transactions
          });
          DotLedger.mainRegion.show(show);
          show.graph.show(balanceGraph);
          show.transactions.show(transactionsTableView);
        }
      });
    },

    newAccount: function () {
      var account, form;
      account = new DotLedger.Models.Account();
      form = new DotLedger.Views.Accounts.Form({
        model: account
      });
      form.on('save', function (model) {
        DotLedger.navigate.showAccount({
          id: model.get('id')
        }, {
          trigger: true
        });
      });
      DotLedger.title('New Account');
      DotLedger.mainRegion.show(form);
    },

    sortAccount: function (accountID) {
      $.ajax({
        url: '/api/transactions/sort',
        data: {
          account_id: accountID
        },
        type: 'POST',
        success: _.bind(function (response) {
          DotLedger.Helpers.Notification.success(response.message);
          DotLedger.Helpers.Loading.stop();
          this.showAccount(accountID);
        }, this)
      });
    },

    editAccount: function (accountID) {
      var account, form;
      account = new DotLedger.Models.Account({
        id: accountID
      });
      form = new DotLedger.Views.Accounts.Form({
        model: account
      });
      account.fetch({
        success: function () {
          DotLedger.title('Edit Account', account.get('name'));
          DotLedger.mainRegion.show(form);
        }
      });
      form.on('save', function () {
        DotLedger.navigate.showAccount({
          id: accountID
        }, {
          trigger: true
        });
      });
    },

    newStatement: function (accountID) {
      var account, form, statement;
      account = new DotLedger.Models.Account({
        id: accountID
      });
      statement = new DotLedger.Models.Statement();
      form = new DotLedger.Views.Statements.Form({
        model: statement,
        account: account
      });
      account.fetch({
        success: function () {
          DotLedger.title('New Statement', account.get('name'));
          DotLedger.mainRegion.show(form);
        }
      });
      form.on('save', function () {
        DotLedger.navigate.showAccount({
          id: accountID
        }, {
          trigger: true
        });
      });
    },

    listStatements: function (accountID) {
      var account, list, statements;
      account = new DotLedger.Models.Account({
        id: accountID
      });
      statements = new DotLedger.Collections.Statements();
      list = new DotLedger.Views.Statements.List({
        account: account,
        collection: statements
      });
      statements.fetch({
        data: {
          account_id: accountID
        }
      });
      account.fetch({
        success: function () {
          DotLedger.title('Statements', account.get('name'));
          DotLedger.mainRegion.show(list);
        }
      });
    },

    listCategories: function () {
      var categories;
      categories = new DotLedger.Collections.Categories();
      DotLedger.title('Categories');
      categories.fetch({
        success: function () {
          var list;
          list = new DotLedger.Views.Categories.List({
            collection: categories
          });
          DotLedger.mainRegion.show(list);
        }
      });
    },

    newCategory: function () {
      var category, form;
      category = new DotLedger.Models.Category();
      form = new DotLedger.Views.Categories.Form({
        model: category
      });
      DotLedger.title('New Category');
      form.on('save', function (model) {
        DotLedger.navigate.listCategories({}, {
          trigger: true
        });
      });
      DotLedger.mainRegion.show(form);
    },

    editCategory: function (categoryID) {
      var category, form;
      category = new DotLedger.Models.Category({
        id: categoryID
      });
      form = new DotLedger.Views.Categories.Form({
        model: category
      });
      form.on('save', function (model) {
        DotLedger.navigate.listCategories({}, {
          trigger: true
        });
      });
      category.fetch({
        success: function () {
          DotLedger.title('Edit Category', category.get('name'));
          DotLedger.mainRegion.show(form);
        }
      });
    },

    listSortingRules: function () {
      var list, sortingRules, updateSortingRules;
      if (!this.QueryParams.has('page')) {
        this.QueryParams.set({
          page: 1
        });
      }

      sortingRules = new DotLedger.Collections.SortingRules();
      list = new DotLedger.Views.SortingRules.List({
        collection: sortingRules,
        model: this.QueryParams
      });

      DotLedger.title('Sorting Rules');

      updateSortingRules = _.bind(function () {
        DotLedger.navigate.listSortingRules(this.QueryParams.attributes);
        sortingRules.fetch({
          data: this.QueryParams.attributes
        });
      }, this);

      list.on('search', updateSortingRules);
      updateSortingRules();
      DotLedger.mainRegion.show(list);
      sortingRules.on('page:change', _.bind(function (page) {
        this.QueryParams.set({
          page: page
        });
        DotLedger.navigate.listSortingRules(this.QueryParams.attributes);
      }, this));
    },

    newSortingRule: function () {
      var form, sortingRule;
      sortingRule = new DotLedger.Models.SortingRule();
      DotLedger.title('New Sorting Rule');
      form = new DotLedger.Views.SortingRules.Form({
        model: sortingRule
      });
      form.on('save', function (model) {
        DotLedger.navigate.listSortingRules({}, {
          trigger: true
        });
        DotLedger.Helpers.SortTransactions.sort();
      });
      DotLedger.mainRegion.show(form);
    },

    editSortingRule: function (sortingRuleID) {
      var form, sortingRule;
      sortingRule = new DotLedger.Models.SortingRule({
        id: sortingRuleID
      });
      form = new DotLedger.Views.SortingRules.Form({
        model: sortingRule
      });
      form.on('save', function (model) {
        DotLedger.navigate.listSortingRules({}, {
          trigger: true
        });
        DotLedger.Helpers.SortTransactions.sort();
      });
      sortingRule.fetch({
        success: function () {
          DotLedger.title('Edit Sorting Rule', sortingRule.get('contains'));
          DotLedger.mainRegion.show(form);
        }
      });
    },

    listGoals: function () {
      var goals;
      goals = new DotLedger.Collections.Goals();
      DotLedger.title('Goals');
      goals.fetch({
        success: function () {
          var list;
          list = new DotLedger.Views.Goals.List({
            collection: goals
          });
          DotLedger.mainRegion.show(list);
        }
      });
    },

    listPayments: function () {
      var balanceGraph, list, payments, paymentsView;
      this.QueryParams.on('change', _.bind(function () {
        DotLedger.navigate.listPayments(this.QueryParams.attributes, {
          replace: true
        });
      }, this));

      if (!this.QueryParams.has('period')) {
        this.QueryParams.set({
          period: 90
        });
      }
      payments = new DotLedger.Collections.Payments();
      paymentsView = new DotLedger.Views.Payments.Payments();
      balanceGraph = new DotLedger.Views.Payments.ProjectedBalanceGraph({
        params: this.QueryParams
      });
      list = new DotLedger.Views.Payments.List({
        collection: payments
      });
      DotLedger.title('Payments');
      payments.fetch({
        success: function () {
          DotLedger.mainRegion.show(paymentsView);
          paymentsView.graph.show(balanceGraph);
          paymentsView.payments.show(list);
        }
      });
    },

    newPayment: function () {
      var form, payment;
      payment = new DotLedger.Models.Payment();
      DotLedger.title('New Payment');
      form = new DotLedger.Views.Payments.Form({
        model: payment
      });
      form.on('save', function (model) {
        DotLedger.navigate.listPayments({}, {
          trigger: true
        });
      });
      DotLedger.mainRegion.show(form);
    },

    editPayment: function (paymentID) {
      var form, payment;
      payment = new DotLedger.Models.Payment({
        id: paymentID
      });
      form = new DotLedger.Views.Payments.Form({
        model: payment
      });
      payment.fetch({
        success: function () {
          DotLedger.title('Edit Payment', payment.get('name'));
          DotLedger.mainRegion.show(form);
        }
      });
      form.on('save', function () {
        DotLedger.navigate.listPayments({}, {
          trigger: true
        });
      });
    },

    listAccountGroups: function () {
      var accountGroups;
      accountGroups = new DotLedger.Collections.AccountGroups();
      DotLedger.title('Account Groups');
      accountGroups.fetch({
        success: function () {
          var list;
          list = new DotLedger.Views.AccountGroups.List({
            collection: accountGroups
          });
          DotLedger.mainRegion.show(list);
        }
      });
    },

    newAccountGroup: function () {
      var accountGroup, form;
      accountGroup = new DotLedger.Models.AccountGroup();
      DotLedger.title('New Account Group');
      form = new DotLedger.Views.AccountGroups.Form({
        model: accountGroup
      });
      form.on('save', function (model) {
        DotLedger.navigate.listAccountGroups({}, {
          trigger: true
        });
      });
      DotLedger.mainRegion.show(form);
    },

    editAccountGroup: function (accountGroupID) {
      var accountGroup, form;
      accountGroup = new DotLedger.Models.AccountGroup({
        id: accountGroupID
      });
      form = new DotLedger.Views.AccountGroups.Form({
        model: accountGroup
      });
      accountGroup.fetch({
        success: function () {
          DotLedger.title('Edit Account Group', accountGroup.get('name'));
          DotLedger.mainRegion.show(form);
        }
      });
      form.on('save', function () {
        DotLedger.navigate.listAccountGroups({}, {
          trigger: true
        });
      });
    },

    listSavedSearches: function () {
      var savedSearches;
      savedSearches = new DotLedger.Collections.SavedSearches();
      DotLedger.title('Saved Searches');
      savedSearches.fetch({
        success: function () {
          var list;
          list = new DotLedger.Views.SavedSearches.List({
            collection: savedSearches
          });
          DotLedger.mainRegion.show(list);
        }
      });
    },

    newSavedSearch: function () {
      var savedSearch, form;
      savedSearch = new DotLedger.Models.SavedSearch(_.omit(this.QueryParams.attributes, ['id']));
      DotLedger.title('New Saved Search');
      form = new DotLedger.Views.SavedSearches.Form({
        model: savedSearch
      });
      form.on('save', function (model) {
        DotLedger.navigate.listSavedSearches({}, {
          trigger: true
        });
      });
      DotLedger.mainRegion.show(form);
    },

    editSavedSearch: function (savedSearchID) {
      var savedSearch, form;
      savedSearch = new DotLedger.Models.SavedSearch({
        id: savedSearchID
      });
      form = new DotLedger.Views.SavedSearches.Form({
        model: savedSearch
      });
      savedSearch.fetch({
        success: function () {
          DotLedger.title('Edit Saved Search', savedSearch.get('name'));
          DotLedger.mainRegion.show(form);
        }
      });
      form.on('save', function () {
        DotLedger.navigate.listSavedSearches({}, {
          trigger: true
        });
      });
    },

    search: function () {
      var searchFilters, searchLayout, searchResults, searchSummary, transactions, updateTransactions;
      if (!this.QueryParams.has('page')) {
        this.QueryParams.set({
          page: 1
        });
      }
      searchLayout = new DotLedger.Views.Search.Search();
      searchFilters = new DotLedger.Views.Search.FilterForm({
        model: this.QueryParams
      });

      transactions = new DotLedger.Collections.Transactions();
      transactions.on('page:change', _.bind(function (page) {
        this.QueryParams.set({
          page: page
        });
        DotLedger.navigate.search(this.QueryParams.attributes);
      }, this));

      searchSummary = new DotLedger.Views.Search.Summary({
        collection: transactions
      });

      updateTransactions = _.bind(function () {
        if (this.QueryParams.has('query')) {
          DotLedger.title('Search', this.QueryParams.get('query'));
        } else {
          DotLedger.title('Search');
        }
        DotLedger.navigate.search(this.QueryParams.attributes);
        transactions.fetch({
          data: this.QueryParams.attributes
        });
      }, this);

      searchFilters.on('search', updateTransactions);
      updateTransactions();
      searchResults = new DotLedger.Views.Transactions.Table({
        collection: transactions,
        showAccountName: true
      });
      DotLedger.mainRegion.show(searchLayout);
      searchLayout.searchFilters.show(searchFilters);
      searchLayout.searchSummary.show(searchSummary);
      searchLayout.searchResults.show(searchResults);
    },

    incomeAndExpenses: function () {
      var categoryStatistics, filterView, renderReport, reportView;
      DotLedger.title('Reports', 'Income and Expenses');
      if (!this.QueryParams.has('period')) {
        this.QueryParams.set({
          period: 90
        });
      }
      DotLedger.navigate.incomeAndExpenses(this.QueryParams.attributes, {
        replace: true
      });
      filterView = new DotLedger.Views.Reports.IncomeAndExpenses.Filter({
        model: this.QueryParams
      });
      reportView = new DotLedger.Views.Reports.IncomeAndExpenses.Show();

      categoryStatistics = new (DotLedger.Collections.Base.extend({
        url: '/api/statistics/activity_per_category'
      }))();

      renderReport = _.bind(function () {
        var dateFrom, dateTo, period;
        DotLedger.navigate.incomeAndExpenses(this.QueryParams.attributes);
        filterView.render();
        dateTo = moment();
        period = this.QueryParams.get('period');
        switch (period) {
          case 'mtd':
            dateFrom = moment().startOf('month');
            break;
          case 'ytd':
            dateFrom = moment().startOf('year');
            break;
          default:
            dateFrom = moment().subtract(period, 'days');
        }
        categoryStatistics.fetch({
          data: {
            date_to: DotLedger.Helpers.Format.queryDate(dateTo),
            date_from: DotLedger.Helpers.Format.queryDate(dateFrom)
          },
          success: function () {
            var activity;
            activity = new DotLedger.Views.Reports.IncomeAndExpenses.Table({
              collection: categoryStatistics
            });
            reportView.report.show(activity);
          }
        });
      }, this);

      this.QueryParams.on('change:period', renderReport);
      renderReport();
      DotLedger.mainRegion.show(reportView);
      reportView.filter.show(filterView);
    }
  });
});
