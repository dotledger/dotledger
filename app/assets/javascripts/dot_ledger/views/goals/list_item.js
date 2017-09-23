DotLedger.module('Views.Goals', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'div',

    className: 'list-group-item',

    template: 'goals/list_item',

    ui: {
      amount: 'input[name=amount]',
      period: 'select[name=period]',
      type: 'select[name=type]'
    },

    initialize: function () {
      this.hasChanged = false;
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      DotLedger.on('options:change', this.renderGoalPeriods, this);
      this.ui.amount.val(this.model.get('amount'));
      this.renderGoalTypes();
      this.renderGoalPeriods();
    },

    renderGoalTypes: function (data) {
      data = (data || DotLedgerData);

      this.ui.type.empty();
      _.each(data.goal_types, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '</option>');
        this.ui.type.append($option);
      }, this));
      this.ui.type.val(this.model.get('type'));
    },

    renderGoalPeriods: function (data) {
      data = (data || DotLedgerData);

      this.ui.period.empty();
      _.each(data.goal_periods, _.bind(function (option) {
        var $option;
        $option = $("<option value='" + option + "'>" + option + '</option>');
        this.ui.period.append($option);
      }, this));
      this.ui.period.val(this.model.get('period'));
    },

    events: {
      'click button.save': 'save',
      'submit form': 'save',
      'change input': 'rerender',
      'change select': 'rerender'
    },

    rerender: function () {
      this.update();
      this.render();
    },

    update: function () {
      var data;
      data = {
        amount: this.ui.amount.val(),
        period: this.ui.period.val(),
        type: this.ui.type.val()
      };
      this.model.set(data);
      if (this.model.hasChanged()) {
        this.hasChanged = true;
      }
    },

    save: function () {
      this.update();
      if (this.hasChanged) {
        this.model.save({}, {
          success: _.bind(function () {
            this.hasChanged = false;
            this.trigger('save', this.model);
          }, this)
        });
      }
      return false;
    },

    templateHelpers: function () {
      return {
        monthAmount: _.bind(function () {
          var amount;
          amount = (function () {
            switch (this.model.get('period')) {
              case 'Month':
                return 1 * this.model.get('amount');
              case 'Fortnight':
                return 1 * this.model.get('amount') * 13.0 / 6;
              case 'Week':
                return 1 * this.model.get('amount') * 13.0 / 3;
            }
          }.call(this));
          return DotLedger.Helpers.Format.money(amount);
        }, this)
      };
    }
  });
});
