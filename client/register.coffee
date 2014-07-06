Meteor.app.packages.register(
  name: "reaction-stripe"
  provides: ['paymentMethod']
  label: "Stripe"
  description: "Stripe Payment for Reaction Commerce"
  icon: "fa fa-globe"
  settingsRoute: "stripe"
  hasWidget: false
  priority: "2"
  shopPermissions: [
    {
      label: "Stripe Payments"
      permission: "dashboard/payments"
      group: "Shop Settings"
    }
  ]
)