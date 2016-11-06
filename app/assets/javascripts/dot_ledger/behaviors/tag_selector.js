DotLedger.module('Behaviors', function () {
  this.TagSelector = Marionette.Behavior.extend({
    initialize: function () {
      // FIXME: This is a hack to make it easier to test.
      if (this.view.options.tags) {
        this.tags = this.view.options.tags;
      } else {
        this.tags = new DotLedger.Collections.Tags();
        this.tags.fetch();
      }
    },

    defaults: {
      showAnyOption: true,
      tagSelect: 'tags',
      tagAttribute: 'tag_ids'
    },

    onRender: function () {
      this.tags.on('sync', _.bind(this.renderTags, this));
      this.renderTags();
    },

    renderTags: function () {
      var $tagSelect;
      $tagSelect = this.view.ui[this.options.tagSelect];
      $tagSelect.empty();

      if (this.options.showAnyOption) {
        $tagSelect.append('<option value="">Any</option>');
      }

      this.tags.each(function (tag) {
        var $option = $("<option value='" + (tag.get('id')) + "'>" + (tag.get('name')) + '</option>');
        $tagSelect.append($option);
      });

      $tagSelect.val(this.view.model.get(this.options.tagAttribute));
    }
  });
});
