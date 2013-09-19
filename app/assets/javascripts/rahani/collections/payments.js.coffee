Rahani.module 'Collections', ->
  class @Payments extends @Base
    url: '/api/payments'
    model: Rahani.Models.Payment
