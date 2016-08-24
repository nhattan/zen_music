require "rails_helper"

RSpec.describe Api::LikesController, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:audio) { FactoryGirl.create(:audio) }

  describe "#create" do
    let(:params) do
      {
        audio_id: audio.id,
      }.to_json
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        post "/api/v1/likes", params, headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end

    context "valid header" do
      context "draft audio" do
        before do
          post "/api/v1/likes", params, authentication_header(user)
        end
        it "responds with an HTTP 404 status code" do
          expect(response).to have_http_status(404)
        end
        it "responses expected body" do
          expect(json_response["success"]).to be false
          expect(json_response["errors"]).to be_a Array
        end
      end

      context "approved audio" do
        before do
          audio.approved!
        end
        it "responds successfully with an HTTP 200 status code" do
          post "/api/v1/likes", params, authentication_header(user)
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
        it "creates like" do
          expect{post "/api/v1/likes", params, authentication_header(user)}.to change{Like.count}.by(1)
        end
        it "responses expected body" do
          post "/api/v1/likes", params, authentication_header(user)
          expect(json_response["success"]).to be true
          expect(json_response["data"]["audio"]).to eq(JSON.parse(audio.reload.to_json))
          expect(json_response["data"]["audio"]["likes_count"]).to eq(1)
        end
      end
    end
  end

  describe "#destroy" do
    let(:audio) { FactoryGirl.create(:audio, status: :approved) }
    let!(:like) { FactoryGirl.create(:like, user: user, audio: audio)}

    context "invalid header" do
      before do
        headers = {:format => :json}
        delete "/api/v1/likes/#{like.id}", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end

    context "valid header" do
      it "responds successfully with an HTTP 200 status code" do
        delete "/api/v1/likes/#{like.id}", authentication_header(user)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "destroys like" do
        expect{delete "/api/v1/likes/#{like.id}", authentication_header(user)}.to change{Like.count}.from(1).to(0)
      end
      it "responses expected body" do
        delete "/api/v1/likes/#{like.id}", authentication_header(user)
        expect(json_response["success"]).to be true
        expect(json_response["data"]["audio"]).to eq(JSON.parse(audio.reload.to_json))
        expect(json_response["data"]["audio"]["likes_count"]).to eq(0)
      end
    end
  end
end
