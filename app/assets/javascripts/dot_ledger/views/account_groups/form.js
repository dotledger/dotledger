DotLedger.module('Views.AccountGroups', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'account_groups/form',

    ui: {
      name: 'input[name=name]'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      this.ui.name.val(this.model.get('name'));
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
            return 'New Account Group';
          }
        }, this)
      };
    },

    update: function () {
      var data;
      data = {
        name: this.ui.name.val()
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
