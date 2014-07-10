Stripe = require("stripe")
Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")

Stripe.setApiKey(Packages.findOne(name: "reaction-stripe").settings.api_key)

console.log "hello"
    
Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (cardData, paymentData) ->
    console.log "test"
    fut = new Future()
    @unblock()
    
    Stripe.charges.create
      amount: paymentData.amount
      currency: paymentData.currency
      card: cardData
    , (err, charge) ->
      console.log err
      console.log charge
      
    fut.wait()
    
    
