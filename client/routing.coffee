Router.map ->
  @route 'stripe',
    controller: ShopAdminController
    path: 'dashboard/settings/stripe',
    template: 'stripe'
    waitOn: ->
      PackagesHandle
  @route 'stripetest',
    controller: ShopAdminController
    path: 'stripetest',
    template: 'stripetest'
    waitOn: ->
      PackagesHandle
  
  @route 'paypaltest',
    controller: ShopAdminController
    path: 'paypaltest',
    template: 'paypalPaymentForm'
    waitOn: ->
      PackagesHandle
      