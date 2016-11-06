DotLedger.module('Views.Statements', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'statements/form',

    ui: {
      file: 'input[name=file]',
      button: 'button'
    },

    events: {
      'click button.save': 'save',
      'submit form': 'save'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
    },

    templateHelpers: function () {
      return {
        accountName: this.options.account.get('name'),
        accountId: this.options.account.get('id')
      };
    },

    save: function () {
      var data, files;
      this.ui.button.button('loading');

      // FIXME: this is a bit hacky
      data = new window.FormData();
      files = this.ui.file[0].files;
      if (files.length > 0) {
        data.append('file', files[0]);
      }

      data.append('account_id', this.options.account.get('id'));

      $.ajax({
        url: '/api/statements',
        data: data,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',
        success: _.bind(function (statement) {
          var transactionCount;
          this.trigger('save');
          this.ui.button.button('reset');
          transactionCount = DotLedger.Helpers.Format.pluralize(statement.transaction_count, 'transaction', 'transactions');
          DotLedger.Helpers.Notification.success(transactionCount + ' imported.');
          DotLedger.Helpers.Loading.stop();
        }, this),
        error: _.bind(function (resp) {
          var errors;
          if (resp.status === 422) {
            this.ui.button.button('reset');
            errors = JSON.parse(resp.responseText).errors;
            this.model.validationError = errors;
            this.model.trigger('invalid', this.model, errors, {
              validationError: errors
            });
          }
          DotLedger.Helpers.Loading.stop();
        }, this)
      });
      return false;
    }
  });
});
