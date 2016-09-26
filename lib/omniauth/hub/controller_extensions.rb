module OmniAuth
  module Hub
    module ControllerExtensions
      extend ActiveSupport::Concern

      included do
        helper_method :current_user_id
        helper_method :current_user
        helper_method :current_organization_id
        helper_method :current_organization

      end

      def current_user_id
        session[:user_id] ? session[:user_id] : nil
      end

      def current_user
        return nil unless current_user_id
        @current_user ||= User.find_by_uid(current_user_id)
      end

      def current_organization_id
        session[:organization_id]
      end

      def current_organization
        return nil unless current_organization_id
        @current_organization ||= User.find_by_uid(current_organization_id)
      end

      def require_user
        if !current_user
          respond_to do |format|
            format.html  {
              redirect_to '/auth/hub'
            }
            format.json {
              render :json => { 'error' => 'Access Denied' }.to_json
            }
          end
        end
      end

    end
  end
end
