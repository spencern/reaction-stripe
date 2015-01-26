Fiber = Npm.require("fibers")
Future = Npm.require("fibers/future")

Meteor.methods
  #submit (sale, authorize)
  stripeSubmit: (transactionType, cardData, paymentData) ->
    Stripe = Npm.require("stripe")(Meteor.Stripe.accountOptions())
    paymentObj = Meteor.Stripe.paymentObj()
    if transactionType is "authorize"
      paymentObj.capture = false
    paymentObj.card = Meteor.Stripe.parseCardData(cardData)
    paymentData = Meteor.Stripe.parsePaymentData(paymentData)
    paymentObj.amount = paymentData.total
    paymentObj.currency = paymentData.currency

    fut = new Future()
    @unblock()

    Stripe.charges.create paymentObj, Meteor.bindEnvironment((err, charge) ->
      if err
        fut.return
          saved: false
          error: err
      else
        fut.return
          saved: true
          charge: charge
      return
    , (e) ->
      ReactionCore.Events.warn e
      return
    )
    fut.wait()


  # capture (existing authorization)
  stripeCapture: (transactionId, captureDetails) ->
    Stripe.configure Meteor.Stripe.accountOptions()

    fut = new Future()
    @unblock()
    Stripe.authorization.capture transactionId, captureDetails, (error, capture) ->
      if error
        fut.return
          saved: false
          error: error
      else
        fut.return
          saved: true
          capture: capture
      return
    fut.wait()

# Meteor.methods
#   #submit (sale, authorize)
#   stripeSubmit: (cardData, paymentData) ->
#
#     api_key = ReactionCore.Collections.Packages.findOne(name: "reaction-stripe").settings.api_key
#     Stripe = Npm.require("stripe")(api_key)
#
#     fut = new Future()
#     @unblock()
#
#     Stripe.charges.create
#       amount: paymentData.amount
#       currency: paymentData.currency
#       card: cardData
#     , (err, payment) ->
#       if err
#         fut.return
#           saved: false
#           error: err
#       else
#         fut.return
#           saved: true
#           payment: payment
#       return
#
#     fut.wait()
