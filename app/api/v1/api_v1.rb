# This class is the bootstrap for all API of a specific version

class V1::ApiV1 < Grape::API

  # This will ensure the URL of the API as: http://<host>/api/v1
  prefix "api/v1"

  # Declare the merchants API for usage, you can add more API as the same way.
  mount V1::Users
  mount V1::Posts

end
