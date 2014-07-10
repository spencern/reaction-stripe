Stripe = Npm.require("stripe")
Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")

test = Packages.findOne(name: "reaction-stripe").settings.api_key
console.log test
Stripe.setApiKey(test)
###
Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (cardData, paymentData) ->
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
### 
    
