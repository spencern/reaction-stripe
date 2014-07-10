

test = Packages.findOne(name: "reaction-stripe").settings.api_key
Stripe = Npm.require("stripe")(test)
Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")
console.log test


Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (cardData, paymentData) ->
    console.log "before"
    fut = new Future()
    @unblock()
    
    console.log "after"
    Stripe.charges.create
      amount: paymentData.amount
      currency: paymentData.currency
      card: cardData
    , (err, charge) ->
      console.log err
      console.log charge
      
    fut.wait()
    
