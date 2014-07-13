Router.map ->
  @route 'stripe',
    controller: ShopAdminController
    path: 'dashboard/settings/stripe',
    template: 'stripe'
    waitOn: ->
      PackagesHandle
Router.map ->
  @route 'stripepaymentform',
    controller: ShopAdminController
    path: 'stripepaymentform',
    template: 'stripePaymentForm'
    waitOn: ->
      PackagesHandle
      