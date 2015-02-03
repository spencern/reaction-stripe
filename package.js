Package.describe({
  summary: "Reaction Stripe - Stripe payments for Reaction Commerce",
  name: "reactioncommerce:reaction-stripe",
  version: "0.2.0",
  git: "https://github.com/reactioncommerce/reaction-stripe.git"
});

Npm.depends({'stripe': '3.0.3'});

Package.onUse(function (api, where) {
  api.versionsFrom('METEOR@1.0');
  api.use("meteor-platform@1.2.1");
  api.use("coffeescript");
  api.use("less");
  api.use("reactioncommerce:core@0.3.0");

  api.add_files([
    "common/register.coffee",
    "common/collections.coffee",
    "lib/stripe.coffee"
    ],["client","server"]);
  api.add_files("server/stripe.coffee",["server"]);
  api.add_files([
    "client/routing.coffee",
    "client/templates/stripe.html",
    "client/templates/stripe.less",
    "client/templates/stripe.coffee",
    "client/templates/cart/checkout/payment/methods/stripe/stripe.html",
    "client/templates/cart/checkout/payment/methods/stripe/stripe.less",
    "client/templates/cart/checkout/payment/methods/stripe/stripe.coffee"
    ],
    ["client"]);

});
