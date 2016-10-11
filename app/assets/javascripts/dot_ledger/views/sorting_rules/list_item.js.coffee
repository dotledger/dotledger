DotLedger.module 'Views.SortingRules', ->
  class @ListItem extends Backbone.Marionette.ItemView

    tagName: 'tr'
  
    template: 'sorting_rules/list_item'

    templateHelpers: ->
      flag: =>
        if @model.get('review')
          'Review'
        else
          ''
    ui:
      delete: 'a.delete-sorting-rule'

    events:
      'click @ui.delete': 'confirmDelete'

    confirmDelete: (e)->
      e.preventDefault()

      confirmation = new DotLedger.Views.Application.ConfirmationModal
        body: "Are you sure you want to delete #{@model.get('contains')}?"
      DotLedger.modalRegion.show(confirmation)

      confirmation.on 'confirm', =>
        @model.destroy(
          wait: true
          success: (model, response, options) ->
            DotLedger.Helpers.Notification.success("Deleted #{model.get('contains')}.")
          error: (model, response, options) ->
            model.serverSideErrors(model, response, options)
            DotLedger.Helpers.Notification.danger(model.validationError.base[0])
        )
