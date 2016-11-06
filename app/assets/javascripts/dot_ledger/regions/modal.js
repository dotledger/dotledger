DotLedger.module('Regions', function () {
  this.Modal = Backbone.Marionette.Region.extend({
    onShow: function (view) {
      view.$el.modal('show');
      this.listenTo(view, 'before:destroy', this.closeModal, this);
    },

    closeModal: function () {
      if (this.currentView) {
        this.stopListening();
        this.currentView.$el.modal('hide');
      }
    }
  });
});
