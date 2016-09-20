require 'rails'

module OmniAuth
  module Hub
    
    # Enables organization support using the gem
    mattr_accessor :enable_organizations
    @@enable_organizations = true

    # Sets the provider url omniauth
    mattr_accessor :provider_url
    @@provider_url = "https://hub.entropi.co"

    # Sets the omniauth application id
    mattr_accessor :omniauth_entropi_app_id
    @@omniauth_entropi_app_id = ""

    mattr_accessor :omniauth_entropi_app_secret
    @@omniauth_entropi_app_secret = ""

    def self.setup
      yield self
    end
  end
end

require "omniauth/entropi/engine"
