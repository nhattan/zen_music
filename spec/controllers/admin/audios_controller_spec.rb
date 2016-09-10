require "rails_helper"

RSpec.describe Admin::AudiosController, :type => :controller do
  let(:audio) { FactoryGirl.create(:audio) }
  let(:params) do
    {
      id: audio.id,
      audio: {
        name: "Jailhouse Rock",
        uploaded_file: fixture_file_upload("audios/Jailhouse Rock.mp3", "audio/mp3")
      }
    }
  end

  describe "POST #update" do
    login_admin

    before do
      put :update, params
    end

    it "redirects to admin audio page" do
      expect(response).to redirect_to(admin_audio_url(audio))
    end
    it { expect(audio.reload.name).to eq params[:audio][:name] }
    it { expect(audio.reload.uploaded_file.file.filename).to eq("Jailhouse_Rock.mp3") }
  end
end
