ReactionCore.registerPackage
  name: "reaction-stripe"
  provides: ['paymentMethod']
  paymentTemplate: "stripePaymentForm"
  label: "Stripe"
  description: "Stripe Payment for Reaction Commerce"
  icon: 'fa fa-shopping-cart'
  settingsRoute: "stripe"
  defaultSettings:
    mode: false
    api_key: ""
  priority: "2"
  hasWidget: true
  shopPermissions: [
    {
      label: "Stripe"
      permission: "dashboard/payments"
      group: "Shop Settings"
    }
  ]
