module UserSessionsHelper
  def login_path(provider = "entropi")
    "/auth/#{provider.to_s}"
  end

  def signup_path(plan_key=nil)
    query_string = plan_key.nil? ? "" : "?plan=#{plan_key}"
    "#{OmniAuth::Hub.provider_url}/register/#{query_string}"
  end

  def checkmark_icon_if_equal(a, b)
    a == b ? "<i class=\"icon-ok\"></i>".html_safe : "&nbsp;&nbsp;&nbsp;&nbsp;".html_safe
  end
end
