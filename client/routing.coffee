Router.map ->
  @route 'stripe',
    controller: ShopAdminController
    path: 'dashboard/settings/stripe',
    template: 'stripe'
  @route 'stripetest',
    controller: ShopAdminController
    path: 'stripetest',
    template: 'stripetest'
    waitOn: ->
      PackagesHandle