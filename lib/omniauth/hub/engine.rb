require "omniauth/strategies/hub"
require "omniauth/hub/controller_extensions"
require "omniauth/hub/concerns/sentient_model"

module OmniAuth
  module Hub
    class Engine < ::Rails::Engine
      initializer 'omniauth.hub.application_controller' do |app|
        ActiveSupport.on_load(:action_controller) do
          include OmniAuth::Hub::ControllerExtensions
        end
      end

      initializer "omniauth.hub.configure_strategy" do |app|
        # Setup Hub Hub OmniAuth Strategy
        app.middleware.use ::OmniAuth::Strategies::Hub,
                              OmniAuth::Hub.omniauth_entropi_app_id,
                              OmniAuth::Hub.omniauth_entropi_app_secret,
                              client_options: { site: OmniAuth::Hub.provider_url}
      end
    end
  end
end
