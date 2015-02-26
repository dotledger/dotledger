DotLedger.module 'Helpers', ->
  @Format =
    money: (number)->
      number ||= 0
      '$' + (parseFloat(number).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'))

    shortDateTime: (date)->
      moment(date).format("D MMM YYYY hh:mm:ss")

    shortDate: (date)->
      moment(date).format("D MMM YYYY")

    queryDate: (date)->
      moment(date).format("YYYY-MM-DD")

    titleDate: (date)->
      moment(date).format('LL')

    unixTimestamp: (date)->
      moment(date).format('X')

    agoDate: (date)->
      moment(date).fromNow()
