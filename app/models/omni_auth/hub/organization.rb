require "active_resource"

class OmniAuth::Hub::Organization < ActiveResource::Base
  self.site = "#{OmniAuth::Hub.provider_url}/api"

  self.primary_key = :uid

  self.user     = OmniAuth::Hub.omniauth_entropi_app_id
  self.password = OmniAuth::Hub.omniauth_entropi_app_secret

  def users
    self.get(:users)
  end
end
