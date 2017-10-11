class ApiController < ActionController::Base

  unless Rails.application.config.consider_all_requests_local

    rescue_from StandardError do |ex|
      log_exception(ex)
      error(status: 500, message: ex.message.to_s, backtrace: ex.backtrace.take(10))
    end

    rescue_from CustomError do |ex|
      log_exception(ex)
      error(status: 400, message: ex.message.to_s, backtrace: ex.backtrace.take(10))
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      log_exception(ex)
      error(status: 403, message: ex.message.to_s, backtrace: ex.backtrace.take(10))
    end

    rescue_from ActionController::ParameterMissing do |ex|
      log_exception(ex)
      error(status: 403, message: ex.message.to_s, backtrace: ex.backtrace.take(10))
    end

    rescue_from ActionController::RoutingError, with: :routing_error

    rescue_from ActiveRecord::RecordNotFound do |ex|
      log_exception(ex)
      error(status: 404, message: ex.message.to_s, backtrace: ex.backtrace.take(10))
    end
  end

  def success(data: nil, serializer: nil, serialize_options: {}, message: nil, extra_info: nil)
    response = {
      status: 200,
      data: []
    }

    serialize_options = serialize_options.merge(
      current_user: current_user
    )

    if data.is_a?(Hash)
      response[:data] = data
    elsif data.present?
      serializer = Api::SuccessResponse.new(
                    object: data,
                    serializer: serializer,
                    serialize_options: serialize_options
                  )
      response = serializer.response
    end

    response[:message] = message if message.present?
    response = response.merge(extra_info) if extra_info.is_a?(Hash)
    render json: response
  end

  def error(status: 403, message: nil, backtrace: nil)
    backtrace =  nil if Rails.env.production?
    render json: { status: status, message: message, backtrace: backtrace }
  end

  def show_exception(ex)
    message = "ERROR: #{ex.message}"
    puts "\n#{'='*message.length}\n"
    puts ">>>  ERROR: #{ex.message}  \n#{params.to_json}"
    puts ex.backtrace.select{|i| i.include?("/app/")}

    if ex.message.include?("PG::")
      log_exception(ex)
    end
  end

  def log_exception(ex)
    Rollbar.error(ex, params: params, user: current_user.try(:as_json))
  end

  private

  def routing_error
    error(status: 404, message: "No route matches.")
  end

end
