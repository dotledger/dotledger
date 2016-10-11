DotLedger.module 'Views.Categories', ->
  class @ListItem extends Backbone.Marionette.ItemView

    tagName: 'div'

    className: 'list-group-item'

    template: 'categories/list_item'

    ui:
      delete: 'a.delete-category'

    events:
      'click @ui.delete': 'confirmDelete'

    confirmDelete: (e)->
      e.preventDefault()

      confirmation = new DotLedger.Views.Application.ConfirmationModal
        body: "Are you sure you want to delete #{@model.get('name')}?"
      DotLedger.modalRegion.show(confirmation)

      confirmation.on 'confirm', =>
        @model.destroy(
          wait: true
          success: (model, response, options) ->
            DotLedger.Helpers.Notification.success("Deleted #{model.get('name')}.")
          error: (model, response, options) ->
            model.serverSideErrors(model, response, options)
            DotLedger.Helpers.Notification.danger(model.validationError.base[0])
        )