require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Hub < OmniAuth::Strategies::OAuth2
      option :name, "hub"
      option :client_options, {
        site: OmniAuth::Hub.provider_url,
        authorize_url:    "/auth/hub/authorize",
        access_token_url: "/auth/hub/access_token"
      }

      uid { raw_info['uid'] }

      info do
        {
          name:  raw_info['info']['name'],
          email: raw_info['info']['email']
        }
      end

      extra do
        {
          organizations:    raw_info['extra']['organizations']    || [],
          subscriptions:    raw_info['extra']['subscriptions']    || [],
          status:           raw_info['extra']['status']           || "",
          is_organization:  raw_info['extra']['is_organization']  || false,
          is_admin:         raw_info['extra']['is_admin']         || false
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/hub/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
