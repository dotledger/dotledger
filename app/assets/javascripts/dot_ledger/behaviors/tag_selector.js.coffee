DotLedger.module 'Behaviors', ->
  class @TagSelector extends Marionette.Behavior

    initialize: ->
      # FIXME: This is a hack to make it easier to test.
      if @view.options.tags
        @tags = @view.options.tags
      else
        @tags = new DotLedger.Collections.Tags()
        @tags.fetch()

    defaults:
      showAnyOption: true
      tagSelect: 'tags'
      tagAttribute: 'tag_ids'

    onRender: ->
      @tags.on 'sync', =>
        @renderTags()
      @renderTags()

    renderTags: ->
      $tagSelect = @view.ui[@options.tagSelect]

      $tagSelect.empty()

      if @options.showAnyOption
        $tagSelect.append('<option value="">Any</option>')

      @tags.each (tag) ->
        $option = $("<option value='#{tag.get('id')}'>#{tag.get('name')}</option>")
        $tagSelect.append($option)

      $tagSelect.val(@view.model.get(@options.tagAttribute))
