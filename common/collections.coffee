console.log "something"
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

###
# Fixture - we always want a record
###
Meteor.startup ->
  unless Packages.findOne({name:"reaction-stripe"})
    Shops.find().forEach (shop) ->
      unless Meteor.settings.stripe
        Meteor.settings.stripe =
          api_key: ""

      Packages.insert
        shopId: shop._id
        name: "reaction-stripe"
        settings: Meteor.settings.stripe
