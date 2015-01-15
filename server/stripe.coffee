
Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")


Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (cardData, paymentData) ->

    api_key = ReactionCore.Collections.Packages.findOne(name: "reaction-stripe").settings.api_key
    Stripe = Npm.require("stripe")(api_key)

    fut = new Future()
    @unblock()

    Stripe.charges.create
      amount: paymentData.amount
      currency: paymentData.currency
      card: cardData
    , (err, payment) ->
      if err
        fut.return
          saved: false
          error: err
      else
        fut.return
          saved: true
          payment: payment
      return

    fut.wait()

