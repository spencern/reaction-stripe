Package.describe({
  summary: "Reaction Stripe - Stripe Payment Module for Reaction commerce",
  name: "reactioncommerce:reaction-stripe",
  version: "1.0.0",
  git: "https://github.com/reactioncommerce/reaction-stripe.git"
});

Npm.depends({'stripe': '3.0.3'});

Package.onUse(function (api, where) {
  api.versionsFrom('METEOR@1.0');
  api.use("meteor-platform");
  api.use("coffeescript");
  api.use("less");
  api.use("reactioncommerce:core@0.2.2");

  api.add_files("common/collections.coffee", ["client","server"]);
  api.add_files("common/register.coffee", ["client","server"]);
  api.add_files("common/routing.coffee", ["client","server"]);

  api.add_files("server/stripe.coffee",["server"]);

  api.add_files([
    "client/templates/stripe.html",
    "client/templates/stripe.coffee",
    "client/templates/stripePaymentForm/stripePaymentForm.html",
    "client/templates/stripePaymentForm/stripePaymentForm.coffee"
  ], ["client"]);

  api.export([
    "StripePackageSchema",
  ], ["client", "server"]);

});
