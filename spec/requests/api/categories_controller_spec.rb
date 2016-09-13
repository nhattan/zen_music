require "rails_helper"

RSpec.describe Api::CategoriesController, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:category_2) { FactoryGirl.create(:category, limited_access: true) }
  let!(:audio_1) { FactoryGirl.create(:audio, category: category, status: :approved) }
  let!(:audio_2) { FactoryGirl.create(:audio, category: category, status: :approved) }
  let!(:audio_3) { FactoryGirl.create(:audio, category: category) }

  describe "#index" do
    context "valid header" do
      context "user is admin" do
        before do
          user.admin!
          get "/api/v1/categories", authentication_header(user)
        end
        it "responds successfully with an HTTP 200 status code" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
        it "responses expected body" do
          expect(json_response["success"]).to be true
          expect(json_response["data"]["categories"]).to be_a Array
        end
        it "returns audios" do
          expect(json_response["data"]["categories"][0]["audios"].map{|x| x['id']}).to eq(category.audios.approved.ids)
        end
        it "returns all categories" do
          expect(json_response["data"]["categories"].map{|x| x['id']}).to eq(Category.ids)
        end
        it "returns children" do
          expect(json_response["data"]["categories"][0]["children"]).to be_a Array
        end
      end

      context "user is not admin" do
        before do
          get "/api/v1/categories", authentication_header(user)
        end
        it "responds successfully with an HTTP 200 status code" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
        it "responses expected body" do
          expect(json_response["success"]).to be true
          expect(json_response["data"]["categories"]).to be_a Array
        end
        it "returns audios" do
          expect(json_response["data"]["categories"][0]["audios"].map{|x| x['id']}).to eq(category.audios.approved.ids)
        end
        it "returns normal categories" do
          expect(json_response["data"]["categories"].map{|x| x['id']}).to eq(Category.normal.ids)
        end
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/categories", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "#show" do
    context "valid header" do
      context "user is admin" do
        before do
          user.admin!
        end
        context "limited access category" do
          before do
            category.update limited_access: true
            get "/api/v1/categories/#{category.id}", authentication_header(user)
          end
          it "responds successfully with an HTTP 200 status code" do
            expect(response).to be_success
            expect(response).to have_http_status(200)
          end
          it "responses expected body" do
            expect(json_response["success"]).to be true
            expect(json_response["data"]["category"]["id"]).to eq category.id
          end
          it "returns audios" do
            expect(json_response["data"]["category"]["audios"].map{|x| x['id']}).to eq(category.audios.approved.ids)
          end
        end

        context "normal category" do
          before do
            get "/api/v1/categories/#{category.id}", authentication_header(user)
          end
          it "responds successfully with an HTTP 200 status code" do
            expect(response).to be_success
            expect(response).to have_http_status(200)
          end
          it "responses expected body" do
            expect(json_response["success"]).to be true
            expect(json_response["data"]["category"]["id"]).to eq category.id
          end
          it "returns audios" do
            expect(json_response["data"]["category"]["audios"].map{|x| x['id']}).to eq(category.audios.approved.ids)
          end
          it "returns children" do
            expect(json_response["data"]["category"]["children"]).to eq(category.children.as_json)
          end
        end
      end

      context "user is not admin" do
        context "limited access category" do
          before do
            category.update limited_access: true
            get "/api/v1/categories/#{category.id}", authentication_header(user)
          end
          it "responds with an HTTP 404 status code" do
            expect(response).to have_http_status(404)
          end
          it "responses expected body" do
            expect(json_response["success"]).to be false
            expect(json_response["errors"]).to be_a Array
          end
        end

        context "normal category" do
          before do
            get "/api/v1/categories/#{category.id}", authentication_header(user)
          end
          it "responds successfully with an HTTP 200 status code" do
            expect(response).to be_success
            expect(response).to have_http_status(200)
          end
          it "responses expected body" do
            expect(json_response["success"]).to be true
            expect(json_response["data"]["category"]["id"]).to eq category.id
          end
          it "returns audios" do
            expect(json_response["data"]["category"]["audios"].map{|x| x['id']}).to eq(category.audios.approved.ids)
          end
          it "returns children" do
            expect(json_response["data"]["category"]["children"]).to eq(category.children.as_json)
          end
        end
      end
    end

    context "invalid header" do
      before do
        headers = {:format => :json}
        get "/api/v1/categories/#{category.id}", headers
      end
      it "responds with an HTTP 401 status code" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
