DotLedger.module('Views.SortingRules', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'sorting_rules/form',

    behaviors: {
      CategorySelector: {
        showAnyOption: false,
        showNoneOption: false
      }
    },

    ui: {
      name: 'input[name=name]',
      contains: 'input[name=contains]',
      category: 'select[name=category]',
      review: 'select[name=review]',
      tags: 'input[name=tags]'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      this.ui.name.val(this.model.get('name'));
      this.ui.contains.val(this.model.get('contains'));
      this.ui.review.val('' + (this.model.get('review'))).change();
      this.ui.tags.val((this.model.get('tag_list') || []).join(', '));
    },

    events: {
      'click button.save': 'save',
      'submit form': 'save'
    },

    templateHelpers: function () {
      return {
        pageHeader: _.bind(function () {
          if (this.model.has('name')) {
            return this.model.get('name');
          } else {
            return 'New Sorting Rule';
          }
        }, this)
      };
    },

    update: function () {
      var data;
      data = {
        name: this.ui.name.val(),
        contains: this.ui.contains.val(),
        category_id: this.ui.category.val(),
        review: this.ui.review.val(),
        tags: this.ui.tags.val()
      };
      this.model.set(data);
    },

    save: function () {
      this.update();
      this.model.save({}, {
        success: _.bind(function () {
          this.trigger('save', this.model);
        }, this)
      });
      return false;
    }
  });
});
