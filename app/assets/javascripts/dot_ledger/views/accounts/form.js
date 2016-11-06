DotLedger.module('Views.Accounts', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'accounts/form',

    behaviors: {
      AccountGroupSelector: {
        showAnyOption: false,
        showNoneOption: true
      }
    },

    ui: {
      name: 'input[name=name]',
      number: 'input[name=number]',
      type: 'select[name=type]',
      account_group: 'select[name=account_group]'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      DotLedger.on('options:change', this.renderAccountTypes, this);
      this.ui.name.val(this.model.get('name'));
      this.ui.number.val(this.model.get('number'));
      this.renderAccountTypes();
    },

    renderAccountTypes: function (data) {
      data = (data || DotLedgerData);

      this.ui.type.empty();
      _.each(data.account_types, _.bind(function (option) {
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
            return 'New Account';
          }
        }, this),
        cancelPath: _.bind(function () {
          if (this.model.get('id')) {
            return DotLedger.path.showAccount({
              id: this.model.get('id')
            });
          } else {
            return DotLedger.path.root();
          }
        }, this)
      };
    },

    update: function () {
      var data;
      data = {
        name: this.ui.name.val(),
        number: this.ui.number.val(),
        type: this.ui.type.val()
      };
      if (this.ui.account_group.val() > -1) {
        data['account_group_id'] = this.ui.account_group.val();
      } else {
        data['account_group_id'] = null;
      }
      this.model.set(data);
    },

    save: function () {
      this.update();
      this.model.save({}, {
        success: _.bind(function () {
          DotLedger.accounts.fetch();
          this.trigger('save', this.model);
        }, this)
      });
      return false;
    }
  });
});
