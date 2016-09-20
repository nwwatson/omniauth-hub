require "omniauth/hub/controller_extensions"
require "omniauth/hub/sentient_user"
require "omniauth/hub/sentient_model"

module OmniAuth
  module Hub
    class Engine < ::Rails::Engine
      initializer 'omniauth.entropi.application_controller' do |app|
        ActiveSupport.on_load(:action_controller) do
          include OmniAuth::Hub::ControllerExtensions
        end
      end

      initializer "omniauth.entropi.configure_strategy" do |app|
        # Setup Hub Hub OmniAuth Strategy
        app.middleware.use ::OmniAuth::Strategies::Hub,
                              OmniAuth::Hub.omniauth_entropi_app_id,
                              OmniAuth::Hub.omniauth_entropi_app_secret,
                              client_options: { site: OmniAuth::Hub.provider_url}
      end
    end
  end
end
