DotLedger.module 'Collections', ->
  class @Payments extends @Base
    url: '/api/payments'
    model: DotLedger.Models.Payment
