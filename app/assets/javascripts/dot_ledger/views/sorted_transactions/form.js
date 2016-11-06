DotLedger.module('Views.SortedTransactions', function () {
  this.Form = Backbone.Marionette.ItemView.extend({
    template: 'sorted_transactions/form',

    className: 'modal',

    behaviors: {
      CategorySelector: {
        showAnyOption: false,
        showNoneOption: false
      }
    },

    ui: {
      name: 'input[name=name]',
      category: 'select[name=category]',
      tags: 'input[name=tags]',
      note: 'textarea[name=note]'
    },

    onRender: function () {
      this.formErrors = new DotLedger.Helpers.FormErrors(this.model, this.$el);
      this.ui.name.val(this.model.get('name') || this.options.transaction.get('search'));
      this.ui.tags.val((this.model.get('tag_list') || []).join(', '));
      this.ui.note.val(this.model.get('note'));
    },

    events: {
      'click button.save': 'save',
      'submit form': 'save'
    },

    update: function () {
      var data;
      data = {
        name: this.ui.name.val(),
        category_id: this.ui.category.val(),
        account_id: this.options.transaction.get('account_id'),
        transaction_id: this.options.transaction.get('id'),
        tags: this.ui.tags.val(),
        note: this.ui.note.val()
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
