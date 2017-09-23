DotLedger.module('Behaviors', function () {
  this.CategorySelector = Marionette.Behavior.extend({
    initialize: function () {
      // FIXME: This is a hack to make it easier to test.
      if (this.view.options.categories) {
        this.categories = this.view.options.categories;
      } else {
        this.categories = new DotLedger.Collections.Categories();
        this.categories.fetch();
      }
    },

    defaults: {
      showAnyOption: true,
      showNoneOption: true,
      categorySelect: 'category',
      categoryAttribute: 'category_id',
      typeSelectable: false
    },

    onRender: function () {
      this.categories.on('sync', _.bind(this.renderCategories, this));
      this.renderCategories();
    },

    renderCategories: function () {
      var $categorySelect;
      $categorySelect = this.view.ui[this.options.categorySelect];
      $categorySelect.empty();

      if (this.options.showAnyOption) {
        $categorySelect.append('<option value="">Any</option>');
      }

      if (this.options.showNoneOption) {
        $categorySelect.append('<option value="-1">None</option>');
      }

      var selectorOptions = this.options;
      _.each(this.categories.groupBy('type'), function (categories, label) {
        var $optgroup;
        $optgroup = $("<optgroup label='" + label + "'></optgroup>");

        if (selectorOptions.typeSelectable) {
          var $option = $("<option value='" + label + "'>Any " + label + '</option>');
          $optgroup.append($option);
        }

        _.each(categories, function (category) {
          var $option = $("<option value='" + (category.get('id')) + "'>" + (category.get('name')) + '</option>');
          $optgroup.append($option);
        });

        $categorySelect.append($optgroup);
      });

      $categorySelect.val(this.view.model.get(this.options.categoryAttribute));
    }
  });
});
