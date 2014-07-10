Package.describe({
  summary: "Reaction Stripe - Stripe Payment Module for Reaction commerce"
});

Npm.depends({'stripe': '2.7.3'});

Package.on_use(function (api, where) {
  api.use([
    "templating",
    "coffeescript",
    "iron-router",
    "simple-schema",
    "autoform",
    "underscore-string-latest",
    "less",
    "reaction-core"
  ], ["client", "server"]);

  api.add_files("common/collections.coffee",["client","server"]);
  api.add_files("server/stripe.coffee",["server"]);
  api.add_files([
    "client/register.coffee",
    "client/routing.coffee",

    "client/templates/stripe.html",
    "client/templates/stripe.coffee",
    "client/templates/stripetest/stripetest.html",
    "client/templates/stripetest/stripetest.coffee"
  ], ["client"]);
  
  api.export([
    "StripePackageSchema",
  ], ["client", "server"]);
  
});