Package.describe({
  summary: "Reaction Stripe - Stripe Payment Module for Reaction commerce"
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

    "client/templates/helloworld/helloworld.html",
    "client/templates/helloworld/helloworld.coffee",
    "client/templates/helloworld/helloworld.less",

    "client/templates/dashboard/widget/widget.html",
    "client/templates/dashboard/widget/widget.coffee",
    "client/templates/dashboard/widget/widget.less"
  ], ["client"]);
});