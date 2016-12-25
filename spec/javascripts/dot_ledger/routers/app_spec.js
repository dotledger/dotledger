describe('DotLedger.Routers.App', function () {
  var createRouter, navigateOptions;
  navigateOptions = {
    trigger: true
  };

  createRouter = function (spy) {
    var router;
    Backbone.history.stop();
    DotLedger.Routers.App.prototype[spy] = $.noop;
    spyOn(DotLedger.Routers.App.prototype, spy);
    router = new DotLedger.Routers.App();
    Backbone.history.start();
    return router;
  };

  it('should be defined', function () {
    expect(DotLedger.Routers.App).toBeDefined();
  });

  describe('Root', function () {
    it('routes to root', function () {
      var router;
      router = createRouter('root');
      router.navigate('/', navigateOptions);
      expect(router.root).toHaveBeenCalled();
    });
  });

  describe('Accounts', function () {
    it('routes to newAccount', function () {
      var router;
      router = createRouter('newAccount');
      router.navigate('/accounts/new', navigateOptions);
      expect(router.newAccount).toHaveBeenCalled();
    });

    it('routes to sortAccount', function () {
      var router;
      router = createRouter('sortAccount');
      router.navigate('/accounts/42/sort', navigateOptions);
      expect(router.sortAccount).toHaveBeenCalledWith('42', {});
    });

    it('routes to editAccount', function () {
      var router;
      router = createRouter('editAccount');
      router.navigate('/accounts/42/edit', navigateOptions);
      expect(router.editAccount).toHaveBeenCalledWith('42', {});
    });

    it('routes to importAccount', function () {
      var router;
      router = createRouter('newStatement');
      router.navigate('/accounts/42/import', navigateOptions);
      expect(router.newStatement).toHaveBeenCalledWith('42', {});
    });

    it('routes to showAccout', function () {
      var router;
      router = createRouter('showAccount');
      router.navigate('/accounts/42', navigateOptions);
      expect(router.showAccount).toHaveBeenCalledWith('42', {});
    });

    it('routes to showAccout with a tab', function () {
      var router;
      router = createRouter('showAccount');
      router.navigate('/accounts/42?tab=sorted', navigateOptions);
      expect(router.showAccount).toHaveBeenCalledWith('42', {
        tab: 'sorted'
      });
    });

    it('routes to showAccout with a tab and page number', function () {
      var router;
      router = createRouter('showAccount');
      router.navigate('/accounts/42?tab=sorted&page=13', navigateOptions);
      expect(router.showAccount).toHaveBeenCalledWith('42', {
        tab: 'sorted',
        page: '13'
      });
    });
  });

  describe('Categories', function () {
    it('routes to listCategories', function () {
      var router;
      router = createRouter('listCategories');
      router.navigate('/categories', navigateOptions);
      expect(router.listCategories).toHaveBeenCalled();
    });

    it('routes to newCategory', function () {
      var router;
      router = createRouter('newCategory');
      router.navigate('/categories/new', navigateOptions);
      expect(router.newCategory).toHaveBeenCalled();
    });

    it('routes to editCategory', function () {
      var router;
      router = createRouter('editCategory');
      router.navigate('/categories/42/edit', navigateOptions);
      expect(router.editCategory).toHaveBeenCalledWith('42', {});
    });
  });

  describe('SortingRules', function () {
    it('routes to listSortingRules', function () {
      var router;
      router = createRouter('listSortingRules');
      router.navigate('/sorting-rules', navigateOptions);
      expect(router.listSortingRules).toHaveBeenCalled();
    });

    it('routes to listSortingRules with params', function () {
      var router;
      router = createRouter('listSortingRules');
      router.navigate('/sorting-rules?foo=bar&baz=42', navigateOptions);
      expect(router.listSortingRules).toHaveBeenCalledWith({
        foo: 'bar',
        baz: '42'
      });
    });

    it('routes to listSortingRules with params and page number', function () {
      var router;
      router = createRouter('listSortingRules');
      router.navigate('/sorting-rules?foo=bar&baz=42&page=13', navigateOptions);
      expect(router.listSortingRules).toHaveBeenCalledWith({
        foo: 'bar',
        baz: '42',
        page: '13'
      });
    });

    it('routes to newSortingRule', function () {
      var router;
      router = createRouter('newSortingRule');
      router.navigate('/sorting-rules/new', navigateOptions);
      expect(router.newSortingRule).toHaveBeenCalled();
    });

    it('routes to editSortingRule', function () {
      var router;
      router = createRouter('editSortingRule');
      router.navigate('/sorting-rules/42/edit', navigateOptions);
      expect(router.editSortingRule).toHaveBeenCalledWith('42', {});
    });
  });

  describe('Goals', function () {
    it('routes to listGoals', function () {
      var router;
      router = createRouter('listGoals');
      router.navigate('/goals', navigateOptions);
      expect(router.listGoals).toHaveBeenCalled();
    });
  });

  describe('Payments', function () {
    it('routes to listPayments', function () {
      var router;
      router = createRouter('listPayments');
      router.navigate('/payments', navigateOptions);
      expect(router.listPayments).toHaveBeenCalled();
    });

    it('routes to newPayment', function () {
      var router;
      router = createRouter('newPayment');
      router.navigate('/payments/new', navigateOptions);
      expect(router.newPayment).toHaveBeenCalled();
    });

    it('routes to editPayment', function () {
      var router;
      router = createRouter('editPayment');
      router.navigate('/payments/42/edit', navigateOptions);
      expect(router.editPayment).toHaveBeenCalledWith('42', {});
    });
  });

  describe('Account Groups', function () {
    it('routes to listAccountGroups', function () {
      var router;
      router = createRouter('listAccountGroups');
      router.navigate('/account-groups', navigateOptions);
      expect(router.listAccountGroups).toHaveBeenCalled();
    });

    it('routes to newAccountGroup', function () {
      var router;
      router = createRouter('newAccountGroup');
      router.navigate('/account-groups/new', navigateOptions);
      expect(router.newAccountGroup).toHaveBeenCalled();
    });

    it('routes to editAccountGroup', function () {
      var router;
      router = createRouter('editAccountGroup');
      router.navigate('/account-groups/42/edit', navigateOptions);
      expect(router.editAccountGroup).toHaveBeenCalledWith('42', {});
    });
  });

  describe('Saved Searches', function () {
    it('routes to listSavedSearches', function () {
      var router;
      router = createRouter('listSavedSearches');
      router.navigate('/saved-searches', navigateOptions);
      expect(router.listSavedSearches).toHaveBeenCalled();
    });

    it('routes to newSavedSearch', function () {
      var router;
      router = createRouter('newSavedSearch');
      router.navigate('/saved-searches/new', navigateOptions);
      expect(router.newSavedSearch).toHaveBeenCalled();
    });

    it('routes to editSavedSearch', function () {
      var router;
      router = createRouter('editSavedSearch');
      router.navigate('/saved-searches/42/edit', navigateOptions);
      expect(router.editSavedSearch).toHaveBeenCalledWith('42', {});
    });
  });

  describe('Search', function () {
    it('routes to search', function () {
      var router;
      router = createRouter('search');
      router.navigate('/search', navigateOptions);
      expect(router.search).toHaveBeenCalled();
    });

    it('routes to search with params', function () {
      var router;
      router = createRouter('search');
      router.navigate('/search?foo=bar&baz=42', navigateOptions);
      expect(router.search).toHaveBeenCalledWith({
        foo: 'bar',
        baz: '42'
      });
    });

    it('routes to search with params and page number', function () {
      var router;
      router = createRouter('search');
      router.navigate('/search?foo=bar&baz=42&page=13', navigateOptions);
      expect(router.search).toHaveBeenCalledWith({
        foo: 'bar',
        baz: '42',
        page: '13'
      });
    });
  });

  describe('Reports', function () {
    it('routes to income and expenses', function () {
      var router;
      router = createRouter('incomeAndExpenses');
      router.navigate('/reports/income-and-expenses', navigateOptions);
      expect(router.incomeAndExpenses).toHaveBeenCalled();
    });
  });
});
