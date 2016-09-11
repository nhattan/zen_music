require "rails_helper"

RSpec.describe Api::AudiosController, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:audio) { FactoryGirl.create(:audio) }

  describe "#index" do
    context "valid header" do
      context "user is not privileged" do
        before do
          user.normal_user!
          get "/api/v1/audios", authentication_header(user)
        end
        it { expect(user.privileged?).to be false }
        it "responds with an HTTP 402 status code" do
          expect(response).to have_http_status(402)
        end
      end
      context "user is privileged" do
        before do
          user.update(role: :normal_user, plan_expires_in: DateTime.tomorrow)
          get "/api/v1/audios", authentication_header(user)
        end
        it { expect(user.privileged?).to be true }
        it "responds successfully with an HTTP 200 status code" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
        it "responses expected body" do
          expect(json_response["success"]).to be true
          expect(json_response["data"]["audios"]).to eq(JSON.parse(Audio.approved.to_json))
        end
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/audios", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "#show" do
    context "valid header" do
      context "draft audio" do
        before do
          get "/api/v1/audios/#{audio.id}", authentication_header(user)
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
          get "/api/v1/audios/#{audio.id}", authentication_header(user)
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
        it "responses expected body" do
          get "/api/v1/audios/#{audio.id}", authentication_header(user)
          expect(json_response["success"]).to be true
          expect(json_response["data"]["audio"]).to eq(JSON.parse(audio.reload.to_json))
        end
        it "creates listen history" do
          expect{get "/api/v1/audios/#{audio.id}", authentication_header(user)}.to change{Listen.count}.by(1)
        end
        it "belongs to audio" do
          get "/api/v1/audios/#{audio.id}", authentication_header(user)
          expect(Listen.last.audio).to eq(audio)
        end
        it "belongs to user" do
          get "/api/v1/audios/#{audio.id}", authentication_header(user)
          expect(Listen.last.user).to eq(user)
        end
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/audios/#{audio.id}", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "#top" do
    context "valid header" do
      before do
        get "/api/v1/audios/top", authentication_header(user)
      end
      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "responses expected body" do
        expect(json_response["success"]).to be true
        expect(json_response["data"]["audios"]).to eq(JSON.parse(Audio.top.to_json))
      end
      it do
        expect(authentication_header(user)).to eq authentication_header(user)
      end
      it "can use valid old authentication_header for validation" do
        get "/api/v1/audios/top", authentication_header(user)
        expect(json_response["success"]).to be true
        expect(json_response["data"]["audios"]).to eq(JSON.parse(Audio.top.to_json))

        get "/api/v1/audios/top", authentication_header(user)
        expect(json_response["success"]).to be true
        expect(json_response["data"]["audios"]).to eq(JSON.parse(Audio.top.to_json))
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/audios/top", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "#favorite" do
    before do
      audio.approved!
    end
    let!(:audio_2) { FactoryGirl.create(:audio, status: :approved) }
    let!(:like_1) { FactoryGirl.create(:like, user: user, audio: audio) }
    let!(:like_2) { FactoryGirl.create(:like, user: user, audio: audio_2) }

    context "valid header" do
      before do
        get "/api/v1/audios/favorite", authentication_header(user)
      end
      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "responses expected body" do
        expect(json_response["success"]).to be true
        expect(json_response["data"]["audios"]).to eq(JSON.parse(user.favorite_audios.order(created_at: :desc).to_json))
      end

      it "returns audios in expected order" do
        expect(json_response["data"]["audios"][0]).to eq(JSON.parse(audio_2.to_json))
        expect(json_response["data"]["audios"][1]).to eq(JSON.parse(audio.to_json))
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/audios/favorite", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
