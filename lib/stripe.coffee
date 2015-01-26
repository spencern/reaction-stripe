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
      amount:
        currency: "USD"
        total: amount
      is_final_capture: true

    Meteor.call "stripeCapture", transactionId, captureDetails, callback
    return

  #config is for the stripe configuration settings.
  config: (options) ->
    @accountOptions = options
    return

  paymentObj: ->
    intent: "sale"
    payer:
      payment_method: "credit_card"
      funding_instruments: []
    transactions: []

  #parseCardData splits up the card data and puts it into a stripe friendly format.
  parseCardData: (data) ->
    credit_card:
      type: data.type
      number: data.number
      first_name: data.first_name
      last_name: data.last_name
      cvv2: data.cvv2
      expire_month: data.expire_month
      expire_year: data.expire_year

  #parsePaymentData splits up the card data and gets it into a stripe friendly format.
  parsePaymentData: (data) ->
    amount:
      total: data.total
      currency: data.currency
