require "rails_helper"

RSpec.describe Api::UsersController, type: :request do
  let(:user) { FactoryGirl.create(:user) }

  describe "#show" do
    context "valid header" do
      context "user did not confirm email" do
        before do
          user.update confirmed_at: nil
          get "/api/v1/users/#{user.id}", authentication_header(user)
        end
        it "responds with an HTTP 404 status code" do
          expect(response).to have_http_status(404)
        end
        it "responses expected body" do
          expect(json_response["success"]).to be false
          expect(json_response["errors"]).to be_a Array
        end
      end

      context "user confirmed email" do
        it "responds successfully with an HTTP 200 status code" do
          get "/api/v1/users/#{user.id}", authentication_header(user)
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
        it "responses expected body" do
          get "/api/v1/users/#{user.id}", authentication_header(user)
          expect(json_response["success"]).to be true
          expect(json_response["data"]["user"]).to eq(JSON.parse(user.reload.to_json))
        end
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/users/#{user.id}", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
