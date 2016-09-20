class OmniAuth::Hub::OrganizationsController < ApplicationController
  before_filter :require_user

  # GET /organizations.json
  def index
    @organizations = []

    @organizations << {
      uid:             current_user.id,
      email:           current_user.email,
      name:            current_user.name,
      status:          current_user.status,
      is_organization: current_user.is_organization
    }

    current_user.organizations.each do |organization|
      @organizations << {
        uid:             organization.id,
        email:           organization.email,
        name:            organization.name,
        status:          organization.status,
        is_organization: organization.is_organization
      }
    end

    render json: @organizations
  end

  # GET /organizations/1/switch
  # GET /organizations/1/switch.json
  def switch
    redirect_url = params[:return_url] || :back

    if params[:organization_id]
      @organization = User.by_is_organization(true).find_by_uid(params[:organization_id])

      if @organization
        session[:organization_id] = @organization.uid

        respond_to do |format|
          format.html { redirect_to redirect_url, notice: "Changed active organization to: #{@organization.name}" }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, flash: { error: "Invalid organization" } }
          format.json { render json: { error: "Invalid organization" }, status: :unprocessable_entity }
        end
      end
    else
      session[:organization_id] = nil

      respond_to do |format|
        format.html { redirect_to redirect_url, notice: "Changed active organization to: (none)" }
        format.json { head :no_content }
      end
    end
  rescue
    respond_to do |format|
      format.html { redirect_to :back, flash: { error: "Invalid organization" } }
      format.json { render json: { error: "Invalid organization" }, status: :unprocessable_entity }
    end
  end
end
