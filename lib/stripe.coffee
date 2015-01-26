Meteor.Stripe =
  accountOptions: ->
    # Note: Stripe does not have a flag for indicating sandbox vs production,
    #       it infers automatically based on the api key provided.
    settings = ReactionCore.Collections.Packages.findOne(name: "reaction-stripe").settings
    return settings.api_key

  #authorize submits a payment authorization to Stripe
  authorize: (cardInfo, paymentInfo, callback) ->
    Meteor.call "stripeSubmit", "authorize", cardInfo, paymentInfo, callback
    return

  # purchase: function(card_info, payment_info, callback){
  #   Meteor.call('stripeSubmit', 'sale', card_info, payment_info, callback);
  # },
  capture: (transactionId, amount, callback) ->
    captureDetails =
      amount: amount

    Meteor.call "stripeCapture", transactionId, captureDetails, callback
    return

  #config is for the stripe configuration settings.
  config: (options) ->
    @accountOptions = options
    return

  chargeObj: ->
    amount: ""
    currency: ""
    card: {}
    capture: true
    currency: ""

  #parseCardData splits up the card data and puts it into a stripe friendly format.
  parseCardData: (data) ->
    number: data.number
    name: data.name
    cvc: data.cvv2
    exp_month: data.expire_month
    exp_year: data.expire_year
