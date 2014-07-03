@StripePackageSchema = new SimpleSchema([
  PackageConfigSchema
  {
    "settings.api_key":
      type: String
      label: "API Client ID"
      min: 60
  }
])

StripePackageSchema = @StripePackageSchema