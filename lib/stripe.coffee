Meteor.Stripe =
  api_key: -> #was_account_options
    settings = Packages.findOne(name: "reaction-stripe").settings
    return settings.api_key

  #authorize submits a payment authorization to Paypal
  authorize: (card_info, payment_info, callback) ->
    Meteor.call "paypalSubmit", "authorize", card_info, payment_info, callback
    return

  # purchase: function(card_info, payment_info, callback){
  #   Meteor.call('paypalSubmit', 'sale', card_info, payment_info, callback);
  # },
  capture: (transactionId, amount, callback) ->
    capture_details =
      amount:
        currency: "USD"
        total: amount
      is_final_capture: true

    Meteor.call "paypalCapture", transactionId, capture_details, callback
    return

  #config is for the paypal configuration settings.
  config: (options) ->
    @account_options = options
    return

  payment_json: ->
    intent: "sale"
    payer:
      payment_method: "credit_card"
      funding_instruments: []
    transactions: []

  #parseCardData splits up the card data and puts it into a paypal friendly format.
  parseCardData: (data) ->
    credit_card:
      type: data.type
      number: data.number
      first_name: data.first_name
      last_name: data.last_name
      cvv2: data.cvv2
      expire_month: data.expire_month
      expire_year: data.expire_year

  #parsePaymentData splits up the card data and gets it into a paypal friendly format.
  parsePaymentData: (data) ->
    amount:
      total: data.total
      currency: data.currency