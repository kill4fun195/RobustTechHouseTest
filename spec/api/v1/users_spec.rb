require 'rails_helper'

require "#{Rails.root}/spec/support/api_helpers"

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe V1::Users do
  context 'Users' do
    let (:user) {User.last}

    context "Sign in" do
      it "valid params" do
        params = {
            email: user.email,
            password: user.password
        }
        post "/api/v1/users/sign_in", params: params, headers: api_header
        expect(response.status).to eq(200)
      end

      it "non-exist account" do
        params = {
            email: "user",
            password: user.password
        }
        post "/api/v1/users/sign_in", params: params, headers: api_header
        expect(response.status).to eq(404)
      end

      it "wrong password" do
        params = {
            email: user.email,
            password: "user.password"
        }
        post "/api/v1/users/sign_in", params: params, headers: api_header
        expect(response.status).to eq(400)
      end
    end

    context "Get dashboard" do
      it "Get dashboard" do
        get "/api/v1/users/dashboard", params: nil, headers: api_header(user.access_token)
        expect(response.status).to eq(200)
      end
    end
  end
end
