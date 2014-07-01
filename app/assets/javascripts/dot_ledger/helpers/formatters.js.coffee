DotLedger.module 'Helpers', ->
  @Format =
    money: (number)->
      number ||= 0
      '$' + (parseFloat(number).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'))
