Package.describe({
  summary: "Reaction Stripe - SStripe Payment Module for Reaction commerce"
});

Package.on_use(function (api, where) {
  api.use([
    "standard-app-packages",
    "coffeescript"
  ], ["client", "server"]);
  api.use([
    "iron-router",
    "less",
    "reaction-core"
  ], ["client"]);

  api.add_files([
    "client/register.coffee",
    "client/routing.coffee",

    "client/templates/stripe/stripe.html",
    "client/templates/stripe/stripe.coffee",

    "client/templates/dashboard/widget/widget.html",
    "client/templates/dashboard/widget/widget.coffee"
  ], ["client"]);
});