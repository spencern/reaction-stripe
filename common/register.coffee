ReactionCore.registerPackage
  name: "reaction-stripe"
  provides: ['paymentMethod']
  paymentTemplate: "stripePaymentForm"
  label: "Stripe"
  description: "Stripe Payment for Reaction Commerce"
  icon: 'fa fa-shopping-cart'
  settingsRoute: "stripe"
  hasWidget: true
  priority: "2"
  shopPermissions: [
    {
      label: "Stripe Payments"
      permission: "dashboard/payments"
      group: "Shop Settings"
    }
  ]