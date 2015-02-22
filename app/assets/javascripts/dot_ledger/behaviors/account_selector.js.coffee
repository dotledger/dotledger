DotLedger.module 'Behaviors', ->
  class @AccountsSelector extends Marionette.Behavior

    initialize: ->
      # FIXME: This is a hack to make it easier to test.
      if @view.options.accounts
        @accounts = @view.options.accounts
      else
        @accounts = new DotLedger.Collections.Accounts()
        @accounts.fetch()

    defaults:
      showAnyOption: true
      accountSelect: 'account'
      accountAttribute: 'account_id'

    onRender: ->
      @accounts.on 'sync', =>
        @renderAccounts()
      @renderAccounts()

    renderAccounts: ->
      $accountSelect = @view.ui[@options.accountSelect]

      $accountSelect.empty()

      if @options.showAnyOption
        $accountSelect.append('<option value="">Any</option>')

      @accounts.each (account) =>
        $option = $("<option value='#{account.get('id')}'>#{account.get('name')}</option>")
        $accountSelect.append($option)

      $accountSelect.val(@view.model.get(@options.accountAttribute))
