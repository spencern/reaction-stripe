Package.describe({
  summary: "Reaction Stripe - Stripe payments for Reaction Commerce",
  name: "reactioncommerce:reaction-stripe",
  version: "1.3.0",
  git: "https://github.com/reactioncommerce/reaction-stripe.git"
});

Npm.depends({'stripe': '3.0.3'});

Package.onUse(function (api, where) {
  api.versionsFrom('METEOR@1.0');
  api.use("meteor-platform");
  api.use("coffeescript");
  api.use("less");
  api.use("reactioncommerce:core@0.5.0");

  api.addFiles("server/register.coffee",["server"]); // register as a reaction package
  api.addFiles("server/stripe.coffee",["server"]);

  api.addFiles([
    "common/collections.coffee",
    "common/routing.coffee",
    "lib/stripe.coffee"
    ],["client","server"]);

  api.addFiles([
    "client/templates/stripe.html",
    "client/templates/stripe.less",
    "client/templates/stripe.coffee",
    "client/templates/cart/checkout/payment/methods/stripe/stripe.html",
    "client/templates/cart/checkout/payment/methods/stripe/stripe.less",
    "client/templates/cart/checkout/payment/methods/stripe/stripe.coffee"
    ],
    ["client"]);
});
