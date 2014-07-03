@StripePackageSchema = new SimpleSchema([
  PackageConfigSchema
  {
    "settings.api_key":
      type: String
      label: "API Client ID"
  }
])

StripePackageSchema = @StripePackageSchema

@StripePaymentSchema = new SimpleSchema
  payerName:
    type: String
    label: "Cardholder name",
    regEx: /^\w+\s\w+$/
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

StripePaymentSchema = @StripePaymentSchema