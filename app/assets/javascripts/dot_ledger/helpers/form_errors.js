DotLedger.module('Helpers', function () {
  this.FormErrors = function (model, $el) {
    this.model = model;
    this.$el = $el;
    _.bindAll(this, 'processInvalid');
    this.listenTo(this.model, 'invalid', this.processInvalid);
  };

  _.extend(this.FormErrors.prototype, Backbone.Events, {
    processInvalid: function (model, errors, options) {
      this.showErrors(errors);
    },

    showErrors: function (errors) {
      this.removeErrors();

      _.each(errors, function (errorMessages, field) {
        this.showError(field, errorMessages);
      }, this);
    },

    showError: function (attribute, errors) {
      var $errorMessages, $errorsContainer, $formGroup;
      $errorMessages = $('<span class="server-side-error help-block" />').html(s.toSentence(errors));
      $formGroup = this.$el.find("[name='" + attribute + "']").parents('.form-group');
      $formGroup.addClass('has-error');
      $errorsContainer = $formGroup.find('.errors');
      $errorsContainer.append($errorMessages);
    },

    removeErrors: function () {
      this.$el.find('.has-error').removeClass('has-error');
      this.$el.find('.server-side-error').remove();
    }
  });
});
