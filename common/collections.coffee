ReactionCore.Schemas.StripePackageConfig = new SimpleSchema([
  ReactionCore.Schemas.PackageConfig
  {
    "settings.api_key":
      type: String
      label: "API Client ID"
  }
])

ReactionCore.Schemas.StripePayment = new SimpleSchema
  payerName:
    type: String
    label: "Cardholder name"
  cardNumber:
    type: String
    min: 16
    label: "Card number"
  expireMonth:
    type: String
    max: 2
    label: "Expiration month"
  expireYear:
    type: String
    max: 4
    label: "Expiration year"
  cvv:
    type: String
    max: 4
    label: "CVV"