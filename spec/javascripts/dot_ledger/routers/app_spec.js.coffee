describe "DotLedger.Routers.App", ->
  navigateOptions = {trigger: true}
  createRouter = (spy)->
    Backbone.history.stop()
    DotLedger.Routers.App::[spy] = $.noop
    spyOn(DotLedger.Routers.App::, spy)
    router = new DotLedger.Routers.App()
    Backbone.history.start()
    router

  it "should be defined", ->
    expect(DotLedger.Routers.App).toBeDefined()

  describe 'Root', ->
    it "routes to root", ->
      router = createRouter('root')
      router.navigate('/', navigateOptions)
      expect(router.root).toHaveBeenCalled()

  describe 'Accounts', ->
    it "routes to newAccount", ->
      router = createRouter('newAccount')
      router.navigate('/accounts/new', navigateOptions)
      expect(router.newAccount).toHaveBeenCalled()

    it "routes to sortAccount", ->
      router = createRouter('sortAccount')
      router.navigate('/accounts/42/sort', navigateOptions)
      expect(router.sortAccount).toHaveBeenCalledWith('42', null)

    it "routes to editAccount", ->
      router = createRouter('editAccount')
      router.navigate('/accounts/42/edit', navigateOptions)
      expect(router.editAccount).toHaveBeenCalledWith('42', null)

    it "routes to importAccount", ->
      router = createRouter('newStatement')
      router.navigate('/accounts/42/import', navigateOptions)
      expect(router.newStatement).toHaveBeenCalledWith('42', null)

    it "routes to showAccout", ->
      router = createRouter('showAccount')
      router.navigate('/accounts/42', navigateOptions)
      expect(router.showAccount).toHaveBeenCalledWith('42', null)

    it "routes to showAccout with a tab", ->
      router = createRouter('showAccount')
      router.navigate('/accounts/42/sorted', navigateOptions)
      expect(router.showAccount).toHaveBeenCalledWith('42', 'sorted', null)

    it "routes to showAccout with a tab and page number", ->
      router = createRouter('showAccount')
      router.navigate('/accounts/42/sorted/page-13', navigateOptions)
      expect(router.showAccount).toHaveBeenCalledWith('42', 'sorted', '13', null)

  describe 'Categories', ->
    it "routes to listCategories", ->
      router = createRouter('listCategories')
      router.navigate('/categories', navigateOptions)
      expect(router.listCategories).toHaveBeenCalled()

    it "routes to newCategory", ->
      router = createRouter('newCategory')
      router.navigate('/categories/new', navigateOptions)
      expect(router.newCategory).toHaveBeenCalled()

    it "routes to editCategory", ->
      router = createRouter('editCategory')
      router.navigate('/categories/42/edit', navigateOptions)
      expect(router.editCategory).toHaveBeenCalledWith('42', null)

  describe 'SortingRules', ->
    it "routes to listSortingRules", ->
      router = createRouter('listSortingRules')
      router.navigate('/sorting-rules', navigateOptions)
      expect(router.listSortingRules).toHaveBeenCalled()

    it "routes to listSortingRules with params", ->
      router = createRouter('listSortingRules')
      router.navigate("/sorting-rules/~(foo~'bar~baz~42)", navigateOptions)
      expect(router.listSortingRules).toHaveBeenCalledWith("~(foo~'bar~baz~42)", null)

    it "routes to listSortingRules with params and page number", ->
      router = createRouter('listSortingRules')
      router.navigate("/sorting-rules/~(foo~'bar~baz~42)/page-13", navigateOptions)
      expect(router.listSortingRules).toHaveBeenCalledWith("~(foo~'bar~baz~42)", '13', null)

    it "routes to newSortingRule", ->
      router = createRouter('newSortingRule')
      router.navigate('/sorting-rules/new', navigateOptions)
      expect(router.newSortingRule).toHaveBeenCalled()

    it "routes to editSortingRule", ->
      router = createRouter('editSortingRule')
      router.navigate('/sorting-rules/42/edit', navigateOptions)
      expect(router.editSortingRule).toHaveBeenCalledWith('42', null)

  describe 'Goals', ->
    it "routes to listGoals", ->
      router = createRouter('listGoals')
      router.navigate('/goals', navigateOptions)
      expect(router.listGoals).toHaveBeenCalled()

  describe 'Payments', ->
    it "routes to listPayments", ->
      router = createRouter('listPayments')
      router.navigate('/payments', navigateOptions)
      expect(router.listPayments).toHaveBeenCalled()

    it "routes to newPayment", ->
      router = createRouter('newPayment')
      router.navigate('/payments/new', navigateOptions)
      expect(router.newPayment).toHaveBeenCalled()

    it "routes to editPayment", ->
      router = createRouter('editPayment')
      router.navigate('/payments/42/edit', navigateOptions)
      expect(router.editPayment).toHaveBeenCalledWith('42', null)

  describe 'Search', ->
    it "routes to search", ->
      router = createRouter('search')
      router.navigate('/search', navigateOptions)
      expect(router.search).toHaveBeenCalled()

    it "routes to search with params", ->
      router = createRouter('search')
      router.navigate("/search/~(foo~'bar~baz~42)", navigateOptions)
      expect(router.search).toHaveBeenCalledWith("~(foo~'bar~baz~42)", null)

    it "routes to search with params and page number", ->
      router = createRouter('search')
      router.navigate("/search/~(foo~'bar~baz~42)/page-13", navigateOptions)
      expect(router.search).toHaveBeenCalledWith("~(foo~'bar~baz~42)", '13', null)
