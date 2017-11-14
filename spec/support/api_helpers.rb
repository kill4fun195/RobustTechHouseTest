module Helpers
  def api_header(access_token = nil)
    ret = { 'X-App-Token': '46df850800c68f98da9efc625bbdcd7f' }
    ret.merge!({'X-Access-Token': access_token}) if access_token
    ret
  end

  def get_with_header(url, access_token = nil)
    get(url, nil, api_header(access_token))
  end

  def post_with_header(url, params, access_token = nil)
    post(url, params, api_header(access_token))
  end
end
