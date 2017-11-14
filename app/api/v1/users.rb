class V1::Users < Grape::API

  helpers ApiHelpers

  helpers do

    def model_class
      User
    end

  end

  resources :users do
    rescue_from Gpolis::Exceptions::InvalidPasswordError do |_e|
      error!({code: Gpolis::Exceptions::INVALID_PASSWORD, error: I18n.t("exceptions.invalid_password")}, 400)
    end

    rescue_from Gpolis::Exceptions::PasswordNotMatchError do |_e|
      error!({code: Gpolis::Exceptions::PASSWORD_NOT_MATCH, error: I18n.t("exceptions.password_not_match")}, 400)
    end

    rescue_from Gpolis::Exceptions::EmailExistError do |_e|
      error!({code: Gpolis::Exceptions::EMAIL_EXIST, error: I18n.t("exceptions.email_exist")}, 400)
    end

    rescue_from Gpolis::Exceptions::EmailNotExistError do |_e|
      error!({code: Gpolis::Exceptions::EMAIL_NOT_EXIST, error: I18n.t("exceptions.email_not_exist")}, 404)
    end

    rescue_from Gpolis::Exceptions::WechatNotExistError do |_e|
      error!({code: Gpolis::Exceptions::WECHAT_NOT_EXIST, error: I18n.t("exceptions.wechat_not_exist")}, 404)
    end

    rescue_from Gpolis::Exceptions::WechatExistError do |_e|
      error!({code: Gpolis::Exceptions::WECHAT_EXIST, error: I18n.t("exceptions.wechat_exist")}, 404)
    end

    rescue_from Gpolis::Exceptions::UserNotExistError do |_e|
      error!({code: Gpolis::Exceptions::USER_NOT_EXIST, error: I18n.t("exceptions.merchant_not_exist")}, 404)
    end

    rescue_from Gpolis::Exceptions::ReferrerNotExistError do |_e|
      error!({code: Gpolis::Exceptions::REFERRER_NOT_EXIST, error: I18n.t("exceptions.referrer_not_exist")}, 404)
    end

    desc "Sign in with email"
    params do
      requires :password, type: String
      requires :email, type: String
    end
    post 'sign_in', jbuilder: 'v1/users/profile' do
      app_authenticated?
      @user = User.where(email: params[:email]).first
      raise Gpolis::Exceptions::EmailNotExistError.new if @user.nil?
      raise Gpolis::Exceptions::InvalidPasswordError.new unless @user.valid_password?(params[:password])
      status(200)
    end

    desc "Change password"
    params do
      requires :old_password, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    put 'change_password', jbuilder:'v1/users/profile' do
      authenticated?
      @user = current_user
      raise Gpolis::Exceptions::InvalidPasswordError.new unless @user.valid_password?(params[:old_password])
      raise Gpolis::Exceptions::PasswordNotMatchError.new if params[:password] != params[:password_confirmation]
      @user.update(params.except(:old_password))
      status(200)
    end

  end

end
