module Gpolis
  class Exceptions
    CODES = [
      INVALID_PASSWORD                   = 1001,
      PASSWORD_NOT_MATCH                 = 1002,
      EMAIL_EXIST                        = 1003,
      EMAIL_NOT_EXIST                    = 1004,
      USER_NOT_EXIST                     = 1005,
      WECHAT_EXIST                       = 1006,
      WECHAT_NOT_EXIST                   = 1007,
      SALE_NOT_EXIST                     = 1008,
      REFERRER_NOT_EXIST                 = 1009,
      REFERRAR_CODE_INVALID              = 1010,
      INVALID_PARAMETER                  = 1011,
      RECORD_NOT_FOUND                   = 1012,
      INVALID_INTRODUCING_RESELLER       = 1013,
      INVALID_CAPTCHA                    = 1101,
      DIVIDEND_EXIST                     = 1201
    ]
    class Error < StandardError; end
    class InvalidPasswordError < Error; end
    class PasswordNotMatchError < Error; end
    class EmailExistError < Error; end
    class EmailNotExistError < Error; end
    class UserNotExistError < Error; end
    class WechatExistError < Error; end
    class WechatNotExistError < Error; end
    class SaleNotExistError < Error; end
    class ReferrerNotExistError < Error; end
    class ReferralCodeNotInvalid < Error; end
    class InvalidParameter < Error; end
    class InvalidIntroducingReseller < Error; end
    class InvalidCaptcha < Error; end
    class DividendExist < Error; end
  end
end
