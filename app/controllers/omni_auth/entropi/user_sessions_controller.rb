class OmniAuth::Hub::UserSessionsController < ApplicationController

  # POST /auth/:provider/callback
  def create

    # Get the OmniAuth authentication callback data.
    omniauth = env['omniauth.auth']

    # Get the UID for the logged-in User.
    uid = omniauth['uid']

    # Try to find the User in the local database.
    user = User.unscoped.find_by_uid(uid)

    # Create the User in the local database if this is the first time this
    # User is signing in to this application.
    user = User.new(uid: uid) unless user

    # Get the info attributes for the User returned from the callback.
    user_info = omniauth['info']

    # Get the additional attributes for the User returned from the callback.
    user_attributes = omniauth['extra']

    # Update the attributes for the User in the local database.
    user.email           = user_info['email']
    user.name            = user_info['name']
    user.status          = user_attributes['status']
    user.is_organization = user_attributes['is_organization']
    user.is_admin        = user_attributes['is_admin']
    user.save

    # Check if organizations are enabled for this application.
    if OmniAuth::Hub.enable_organizations
      organizations = user_attributes['organizations'] || []
      organizations.each do |o|

        # Try to find the organization User in the local database.
        organization = User.unscoped.find_by_uid(o['id'])

        # Create the organization User in the local database if it does not
        # yet exist here.
        organization = User.new(uid: o['id']) unless organization

        # Update the attributes for the organization User in the local database.
        organization.email           = o['email']
        organization.name            = o['name']
        organization.status          = o['status']
        organization.is_organization = o['is_organization']
        organization.is_admin        = o['is_admin']
        organization.save

        # Find or create a Membership for the logged-in User and the current
        # organization User.
        membership = Membership.find_or_create_by_user_id_and_organization_id(user.uid, organization.uid)
        membership.save if membership.new_record?
      end

      # Clear the current organization User ID from session. This will cause
      # the initial active organization for the logged-in User to be "(none)".
      session[:organization_id] = nil
    end

    Rails.logger.info "*******************************************************************"
    Rails.logger.info omniauth['extra']
    Rails.logger.info "*******************************************************************"

    subscriptions = user_attributes['subscriptions'] || []
    subscriptions.each do |sub|
      subscription = Subscription.find_by_sid(sub['id']) || Subscription.new(sid: sub['id'])

      subscription.sid          = sub['id']
      subscription.uid          = sub['user_id']
      subscription.plan_id      = sub['plan_id']
      subscription.plan_name    = sub['plan_name']
      subscription.plan_key     = sub['plan_key']
      subscription.started_at   = sub['started_at']
      subscription.canceled_at  = sub['canceled_at']

      subscription.save
    end

    # Store the OmniAuth authentication callback data in session.
    Rails.logger.info omniauth
    Rails.logger.info "#{omniauth['uid']}"
    session[:user_id] = omniauth['uid']

    # Display a message indicating a successful login and redirect to this
    # application's root URL.
    flash[:notice] = "You have logged in successfully"
    redirect_to root_url
  end

  # POST /auth/failure
  def failure
    # Display a message indicating a failure occurred during login.
    flash[:error] = params[:message]
  end

  # GET /logout
  def destroy
    # Clear all session data.
    reset_session
    # Check if a redirect URL was provided.
    redirect_url_param = params[:redirect_url] ? "?redirect_url=#{params[:redirect_url]}" : ""

    Rails.logger.info "*******************************************************************"
    Rails.logger.info OmniAuth::Hub.provider_url
    Rails.logger.info "*******************************************************************"

    # Display a message indicating a successful logout and redirect to the
    # authentication provider to logout globally.
    flash[:notice] = "You have logged out successfully"
    redirect_to "#{OmniAuth::Hub.provider_url}/logout#{redirect_url_param}"
  end
end
