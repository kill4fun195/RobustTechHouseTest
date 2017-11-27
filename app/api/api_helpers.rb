module ApiHelpers

  def app_token
    Rails.application.secrets.app_token || "46df850800c68f98da9efc625bbdcd7f"
  end

  def params_app_token
    request.headers["X-App-Token"].presence
  end

  def app_authenticated?
    return true if app_token == params_app_token
    return unauthenticated
  end

  def params_access_token
    request.headers["X-Access-Token"].presence
  end

  def current_user
    access_token = params_access_token
    @current_user ||= (access_token && User.find_by_access_token(access_token))
    @current_user
  end

  def authenticated?
    return true if current_user
    return unauthenticated
  end

  def unauthenticated
    error!({error: "Unauthenticated", code: 401}, 401)
  end

  def model_class
    # This method has to be implemented in API class as a helper
  end


  def create_pagination_params(page, per_page, total_pages, count)
    {
        page: page,
        per_page: per_page,
        total_pages: total_pages,
        count: count
    }
  end


end
