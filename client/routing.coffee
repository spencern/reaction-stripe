Router.map ->
  @route 'stripe',
    controller: ShopAdminController
    path: 'dashboard/settings/stripe',
    template: 'stripe'
    waitOn: ->
      PackagesHandle
  @route 'stripetest',
    controller: ShopController
    path: 'stripetest',
    template: 'stripetest'
    waitOn: ->
      PackagesHandle