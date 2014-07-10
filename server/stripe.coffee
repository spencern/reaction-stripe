api_key = Packages.findOne(name: "reaction-stripe").settings.api_key

Stripe = Npm.require("stripe")(api_key)
Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")


Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (cardData, paymentData) ->
    
    Stripe.charges.create
      amount: paymentData.amount
      currency: paymentData.currency
      card: cardData
    , (err, charge) ->
      console.log err
      console.log charge
      
    console.log "hellO"
    
