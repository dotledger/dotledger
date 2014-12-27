DotLedger.module 'Views.Accounts', ->
  class @Show extends Backbone.Marionette.LayoutView
    initialize: (options)->
      @tab = options.tab

    template: 'accounts/show'

    regions:
      transactions: '#transactions'

    ui:
      balanceGraph: '.balance .graph'
      balanceTooltip: '.balance .tooltip'
      balanceTooltipInner: '.balance .tooltip .tooltip-inner'

    balanceGraphData: ->
      [
        {
          color: 'rgb(111, 202, 194)'
          data: @options.balances.map (balance) ->
            [moment(balance.get('date')).toDate().getTime(), balance.get('balance')]
        }
      ]

    balanceGraphOptions: ->
      series:
        shadowSize: 1
        lines:
          show: true
          lineWidth: 2
          fill: true
          fillColor: 'rgba(111, 202, 194, 0.6)'
      grid:
        borderWidth: 0
        hoverable: true
      points:
        radius: 2
      xaxis:
        mode: "time"
        timeformat: "%e %b"
        tickLength: 0
      yaxis:
        tickColor: 'rgba(238, 238, 238, 1)'

    renderBalanceGraph: ->
      $.plot(@ui.balanceGraph, @balanceGraphData(), @balanceGraphOptions())

      @ui.balanceGraph.bind "plothover", (event, pos, item) =>
        if item
          balance = DotLedger.Helpers.Format.money(item.datapoint[1])
          @ui.balanceTooltipInner.html(balance)
          @ui.balanceTooltip.css(
            top: item.pageY - 35
            left: item.pageX - 40
          ).addClass('in')
        else
          @ui.balanceTooltip.removeClass('in')

    onRender: ->
      @$el.find("a[data-tab-id='#{@tab}-transactions']").parent().addClass('active')

      _.defer(=> @renderBalanceGraph())
