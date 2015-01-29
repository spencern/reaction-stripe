Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")

Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (transactionType, cardData, paymentData) ->
    Stripe = Npm.require("stripe")(Meteor.Stripe.accountOptions())
    chargeObj = Meteor.Stripe.chargeObj()
    if transactionType is "authorize"
      chargeObj.capture = false
    chargeObj.card = Meteor.Stripe.parseCardData(cardData)
    chargeObj.amount = parseFloat(paymentData.total) * 100
    chargeObj.currency = paymentData.currency

    fut = new Future()
    @unblock()

    Stripe.charges.create chargeObj, Meteor.bindEnvironment((error, result) ->
      if error
        fut.return
          saved: false
          error: error
      else
        fut.return
          saved: true
          response: result
      return
    , (e) ->
      ReactionCore.Events.warn e
      return
    )
    fut.wait()

  # capture (existing authorization)
  stripeCapture: (transactionId, captureDetails) ->
    Stripe = Npm.require("stripe")(Meteor.Stripe.accountOptions())

    fut = new Future()
    @unblock()
    Stripe.charges.capture transactionId, captureDetails, Meteor.bindEnvironment((error, result) ->
      if error
        fut.return
          saved: false
          error: error
      else
        fut.return
          saved: true
          response: result
      return
    , (e) ->
      ReactionCore.Events.warn e
      return
    )
    fut.wait()
