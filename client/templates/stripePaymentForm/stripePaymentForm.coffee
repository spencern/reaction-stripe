getCardType = (number) ->
  re = new RegExp("^4")
  return "visa"  if number.match(re)?
  re = new RegExp("^(34|37)")
  return "amex"  if number.match(re)?
  re = new RegExp("^5[1-5]")
  return "mastercard"  if number.match(re)?
  re = new RegExp("^6011")
  return "discover"  if number.match(re)?
  ""

uiEnd = (template, buttonText) ->
  template.$(":input").removeAttr("disabled")
  template.$("#btn-complete-order").text(buttonText)
  template.$("#btn-processing").addClass("hidden")

paymentAlert = (errorMessage) ->
  $(".alert").removeClass("hidden").text(errorMessage)

hidePaymentAlert = () ->
  $(".alert").addClass("hidden").text('')

handleStripeSubmitError = (error) -> #Stripe Error Handling
  if error?.message
    paymentAlert error.message

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
      amount: parseInt(Session.get("cartTotal")) * 100
      currency: Shops.findOne().currency
    }

    # Reaction only stores type and 4 digits
    storedCard = getCardType(doc.cardNumber).charAt(0).toUpperCase() + getCardType(doc.cardNumber).slice(1) + " " + doc.cardNumber.slice(-4)


    # Order Layout
    $(".list-group a").css("text-decoration", "none")
    $(".list-group-item").removeClass("list-group-item")

    Meteor.call "stripeSubmit", cardData, paymentData
    , (error, transaction) ->
      submitting = false
      if error
        # this only catches connection/authentication errors
        handleStripeSubmitError(error)
        # Hide processing UI
        uiEnd(template, "Resubmit payment")
        return
      else
        if transaction.saved is true #successful transaction

          # This is where we need to decide how much of the Stripe
          # response object we need to pass to CartWorkflow
          paymentMethod =
            processor: "Stripe"
            storedCard: storedCard
            method: transaction.payment.card.funding
            transactionId: transaction.payment.id
            amount: transaction.payment.amount
            # not sure what the stripe equivalents are here
            # status: transaction.payment.state
            # mode: transaction.payment.intent
            createdAt: new Date(transaction.payment.create_time)
            updatedAt: new Date(transaction.payment.update_time)

          # Store transaction information with order
          # paymentMethod will auto transition to
          # CartWorkflow.paymentAuth() which
          # will create order, clear the cart, and update inventory,
          # and goto order confirmation page
          CartWorkflow.paymentMethod(paymentMethod)
          return
        else # card errors are returned in transaction
          handleStripeSubmitError(transaction.error)
          # Hide processing UI
          uiEnd(template, "Resubmit payment")
          return

    return false;

  beginSubmit: (formId, template) ->
    # Show Processing
    template.$(":input").attr("disabled", true)
    template.$("#btn-complete-order").text("Submitting ")
    template.$("#btn-processing").removeClass("hidden")
  endSubmit: (formId, template) ->
    # Hide processing UI here if form was not valid
    uiEnd(template, "Complete your order") if not submitting
