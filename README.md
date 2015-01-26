reaction-stripe
===============

Meteor/Reaction Package for Stripe integration.

### Usage
```console
`meteor add reactioncommerce:reaction-stripe`
```

This is a prototype module -> pull requests are celebrated, feedback encouraged.

International user? See: https://github.com/reactioncommerce/reaction/issues/96

### Configuration
In settings/settings.json file, or via dashboard configuration:
```json
"stripe": {
  "api_key": "<your stripe API key>",
}
```
Note: Stripe automatically infers sandbox vs production mode based on API key used.

This overrides the dummy fixture data in common/collections.coffee

```coffeescript
Meteor.settings.stripe =
  api_key: ""
```

#### Use

```coffeescript
Meteor.Stripe.authorize
  name: 'Buster Bluth'
  number: '4242424242424242'
  cvv2: '123'
  expire_year: '2016'
  expire_month: '01'
,
  total: '100.10'
  currency: 'USD'
, (error, results) ->
  if error
  # Deal with Error
  else
  # results contains boolean for saved
  # and a payment object with information about the transaction
```

```coffeescript
Meteor.Stripe.capture "<stripe charge id>",
  total: '100.10'
, (error, results) ->
  if error
    # Deal with Error
  else
    # results contains boolean for saved
    # and a payment object with information about the transaction
```

Note: this package automatically converts the total charge amount into smallest currency units as is required by Stripe before the API call is made.

For information on the **charge** object returned see [Stripe's Charges Documentation](https://stripe.com/docs/api#charges)
