# This class is the bootstrap for all API

class API < Grape::API

  format :json
  formatter :json, Grape::Formatter::Jbuilder

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!({ code: 404, error: e.message }, 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error!({ code: 400, error: e.message }, 400)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!({ code: 400, error: e.message }, 400)
  end

  if Rails.env.production?
    rescue_from :all do |e|
      error!({ code: 500, error: e.message }, 500)
      Rails.logger.debug e
    end
  end

  # Add more API versions here (if any)
  mount V1::ApiV1

end
