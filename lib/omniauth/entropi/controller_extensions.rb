module OmniAuth
  module Hub
    module ControllerExtensions
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.helper_method :current_user_id
        base.helper_method :current_user
        base.helper_method :current_organization_id
        base.helper_method :current_organization

        base.class_eval do
          before_filter do |controller|
            Thread.current[:user] = controller.send(:current_user)
            Thread.current[:organization] = controller.send(:current_organization)
          end
        end
      end

      module InstanceMethods

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
                redirect_to '/auth/entropi'
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
end
