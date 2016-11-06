DotLedger.module('Views.Payments', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'payments/form',

    behaviors: {
      CategorySelector: {
        showAnyOption: false,
        showNoneOption: false
      }
    },

    ui: {
      name: 'input[name=name]',
      amount: 'input[name=amount]',
      category: 'select[name=category]',
      date: 'input[name=date]',
      repeat: 'input[name=repeat]',
      repeat_interval: 'input[name=repeat_interval]',
      repeat_period: 'select[name=repeat_period]',
      type: 'select[name=type]'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      DotLedger.on('options:change', this.renderPaymentTypes, this);
      DotLedger.on('options:change', this.renderPaymentPeriods, this);
      this.ui.name.val(this.model.get('name'));
      this.ui.amount.val(this.model.get('amount'));
      this.ui.date.val(this.model.get('date'));
      this.ui.date.datepicker({
        format: 'yyyy-mm-dd'
      });
      this.ui.repeat.prop('checked', this.model.get('repeat'));
      this.ui.repeat_interval.val(this.model.get('repeat_interval'));
      this.ui.repeat_period.val(this.model.get('repeat_period'));
      this.renderPaymentTypes();
      this.renderPaymentPeriods();
      this.toggleRepeat();
    },

    renderPaymentTypes: function (data) {
      data = (data || DotLedgerData);

      this.ui.type.empty();
      _.each(data.payment_types, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '</option>');
        this.ui.type.append($option);
      }, this));
      this.ui.type.val(this.model.get('type'));
    },

    renderPaymentPeriods: function (data) {
      data = (data || DotLedgerData);

      this.ui.repeat_period.empty();

      _.each(data.payment_periods, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '(s)</option>');
        this.ui.repeat_period.append($option);
      }, this));

      this.ui.repeat_period.val(this.model.get('repeat_period'));
    },

    events: {
      'click button.save': 'save',
      'submit form': 'save',
      'change input[name=repeat]': 'toggleRepeat'
    },

    templateHelpers: function () {
      return {
        pageHeader: _.bind(function () {
          if (this.model.has('name')) {
            return this.model.get('name');
          } else {
            return 'New Payment';
          }
        }, this)
      };
    },

    toggleRepeat: function () {
      if (this.ui.repeat.prop('checked')) {
        this.ui.repeat_period.parents('.form-group').show();
        this.ui.repeat_interval.parents('.form-group').show();
      } else {
        this.ui.repeat_period.parents('.form-group').hide();
        this.ui.repeat_interval.parents('.form-group').hide();
      }
    },

    update: function () {
      var data;
      data = {
        name: this.ui.name.val(),
        amount: this.ui.amount.val(),
        category_id: this.ui.category.val(),
        date: this.ui.date.val(),
        repeat: this.ui.repeat.prop('checked'),
        repeat_interval: this.ui.repeat_interval.val(),
        repeat_period: this.ui.repeat_period.val(),
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
