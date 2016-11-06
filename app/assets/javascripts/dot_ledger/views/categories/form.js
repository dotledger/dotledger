DotLedger.module('Views.Categories', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'categories/form',

    ui: {
      name: 'input[name=name]',
      type: 'select[name=type]'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      DotLedger.on('options:change', this.renderCategoryTypes, this);
      this.ui.name.val(this.model.get('name'));
      this.renderCategoryTypes();
    },

    renderCategoryTypes: function (data) {
      data = (data || DotLedgerData);

      this.ui.type.empty();
      _.each(data.category_types, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '</option>');
        this.ui.type.append($option);
      }, this));
      this.ui.type.val(this.model.get('type'));
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
            return 'New Category';
          }
        }, this)
      };
    },

    update: function () {
      var data;
      data = {
        name: this.ui.name.val(),
        type: this.ui.type.val()
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
