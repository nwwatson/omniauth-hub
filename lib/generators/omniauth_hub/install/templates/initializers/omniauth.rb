require 'omniauth/strategies/entropi'

OmniAuth::Hub.setup do |config|
  # ==> Configuration for Multiple Organizations
  # Setting to true will allow the application to use
  # organizational switching, allowing members to view
  # more than one user/organizations data at a time
  # the default for this value is "true"
  # config.enable_organizations = ENV["OMNIAUTH_HUB_ENABLE_ORGANIZATIONS"]

  # ==> Configuration for authentication host
  # Configure the host which will provide authentication for the application.
  # By default, this is "https://hub.entropi.co".
  config.provider_url = ENV["OMNIAUTH_HUB_PROVIDER_URL"]

  # ==> Configuration for Application ID provided by
  # Hub for authentication
  config.omniauth_entropi_app_id = ENV["OMNIAUTH_HUB_APP_ID"]

  # ==> Configuration for Application Secret provided
  # by Hub for authentication
  config.omniauth_entropi_app_secret = ENV["OMNIAUTH_HUB_APP_SECRET"]
end
