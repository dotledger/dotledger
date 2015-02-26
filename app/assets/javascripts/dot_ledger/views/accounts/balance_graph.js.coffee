DotLedger.module 'Views.Accounts', ->
  class @BalanceGraph extends Backbone.Marionette.ItemView
    tagName: 'div'

    template: 'accounts/balance_graph'

    balances: new DotLedger.Collections.Balances()

    fetchBalances: ->
      @balances.fetch
        data:
          account_id: @model.id
          date_from: DotLedger.Helpers.Format.queryDate(moment().subtract(@options.days, 'days'))
          date_to: DotLedger.Helpers.Format.queryDate()

    ui:
      balanceGraph: '.balance .graph'
      balanceTooltip: '.balance .tooltip'
      balanceTooltipInner: '.balance .tooltip .tooltip-inner'

    balanceGraphData: ->
      [
        {
          color: 'rgb(111, 202, 194)'
          data: @balances.map (balance) ->
            [DotLedger.Helpers.Format.unixTimestamp(balance.get('date')), balance.get('balance')]
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
      @balances.on 'sync', =>
        @renderBalanceGraph()

      @fetchBalances()
      _.defer(=> @renderBalanceGraph())
