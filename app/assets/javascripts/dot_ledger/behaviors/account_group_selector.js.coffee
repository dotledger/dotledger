DotLedger.module 'Behaviors', ->
  class @AccountGroupSelector extends Marionette.Behavior

    initialize: ->
      # FIXME: This is a hack to make it easier to test.
      if @view.options.account_groups
        @account_groups = @view.options.account_groups
      else
        @account_groups = new DotLedger.Collections.AccountGroups()
        @account_groups.fetch()

    defaults:
      showAnyOption: true
      showNoneOption: true
      accountGroupSelect: 'account_group'
      accountGroupAttribute: 'account_group_id'

    onRender: ->
      @account_groups.on 'sync', =>
        @renderAccountGroups()
      @renderAccountGroups()

    renderAccountGroups: ->
      $accountGroupSelect = @view.ui[@options.accountGroupSelect]

      $accountGroupSelect.empty()

      if @options.showAnyOption
        $accountGroupSelect.append('<option value="">Any</option>')

      if @options.showNoneOption
        $accountGroupSelect.append('<option value="-1">None</option>')

      @account_groups.each (account_group) ->
        $option = $("<option value='#{account_group.get('id')}'>#{account_group.get('name')}</option>")
        $accountGroupSelect.append($option)

      val = @view.model.get(@options.accountGroupAttribute)
      if val == null
        val = -1
      $accountGroupSelect.val(val)
