uiEnd = (template, buttonText) ->
  template.$(":input").removeAttr("disabled")
  template.$("#btn-complete-order").text(buttonText)
  template.$("#btn-processing").addClass("hidden")

paymentAlert = (errorMessage) ->
  $(".alert").removeClass("hidden").text(errorMessage)

hidePaymentAlert = () ->
  $(".alert").addClass("hidden").text('')

handlePaypalSubmitError = (error) ->
  # Depending on what they are, errors come back from PayPal in various formats
  singleError = error?.response?.error_description
  serverError = error?.response?.message
  errors = error?.response?.details || []
  if singleError
    paymentAlert("Oops! " + singleError)
  else if errors.length
    for error in errors
      formattedError = "Oops! " + error.issue + ": " + error.field.split(/[. ]+/).pop().replace(/_/g,' ')
      paymentAlert(formattedError)
  else if serverError
    paymentAlert("Oops! " + serverError)

Template.stripePaymentForm.helpers
  cartPayerName: ->
    Cart.findOne()?.payment?.address?.fullName

  monthOptions: () ->
    monthOptions =
      [
        { value: "", label: "Choose month"}
        { value: "01", label: "1 - January"}
        { value: "02", label: "2 - February" }
        { value: "03", label: "3 - March" }
        { value: "04", label: "4 - April" }
        { value: "05", label: "5 - May" }
        { value: "06", label: "6 - June" }
        { value: "07", label: "7 - July" }
        { value: "08", label: "8 - August" }
        { value: "09", label: "9 - September" }
        { value: "10", label: "10 - October" }
        { value: "11", label: "11 - November" }
        { value: "12", label: "12 - December" }
      ]
    monthOptions

  yearOptions: () ->
    yearOptions = [{ value: "", label: "Choose year" }]
    year = new Date().getFullYear()
    for x in [1...9] by 1
      yearOptions.push { value: year , label: year}
      year++
    yearOptions

# used to track asynchronous submitting for UI changes
submitting = false

AutoForm.addHooks "stripe-payment-form",
  onSubmit: (doc) ->
    # Process form (pre-validated by autoform)
    submitting = true
    template = this.template
    hidePaymentAlert()

    cardData = {
      name: doc.payerName
      number: doc.cardNumber
      exp_month: doc.expireMonth
      exp_year: doc.expireYear
      cvc: doc.cvv
    }

    paymentData = {
      # Stripe requires the amount to be a positive integer in the smallest currency unit (cent)
      amount: parseFloat(Session.get("cartTotal")) * 100 # Assumes currency is USD. Need to refactor to be based on shop currency
      currency: "usd" # Shops.findOne().currency
    }

    
    # Order Layout
    $(".list-group a").css("text-decoration", "none")
    $(".list-group-item").removeClass("list-group-item")
    
    Meteor.call "stripeSubmit", cardData, paymentData
    , (error, transaction) ->
      submitting = false
      if error
        # this only catches connection/authentication errors
        handlePaypalSubmitError(error)
        # Hide processing UI
        uiEnd(template, "Resubmit payment")
        return
      else
        if transaction.saved is true #successful transaction
          # Format the transaction to store with order and submit to CartWorkflow
          paymentMethod =
            processor: "Stripe"
            storedCard: storedCard
            method: transaction.payment.payer.payment_method
            transactionId: transaction.payment.transactions[0].related_resources[0].authorization.id
            amount: transaction.payment.transactions[0].amount.total
            status: transaction.payment.state
            mode: transaction.payment.intent
            createdAt: new Date(transaction.payment.create_time)
            updatedAt: new Date(transaction.payment.update_time)

  beginSubmit: (formId, template) ->
    # Show Processing
    template.$(":input").attr("disabled", true)
    template.$("#btn-complete-order").text("Submitting ")
    template.$("#btn-processing").removeClass("hidden")
  endSubmit: (formId, template) ->
    # Hide processing UI here if form was not valid
    uiEnd(template, "Complete your order") if not submitting