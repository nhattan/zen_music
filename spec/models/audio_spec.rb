require "rails_helper"

RSpec.describe Audio, :type => :model do
  let(:audio_1) { FactoryGirl.create(:audio, status: :approved) }
  let(:audio_2) { FactoryGirl.create(:audio, status: :approved) }
  let(:audio_3) { FactoryGirl.create(:audio, status: :approved) }
  let(:audio_4) { FactoryGirl.create(:audio, status: :approved) }
  let(:audio_5) { FactoryGirl.create(:audio) }

  let(:user_1) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user) }

  describe "#top" do
    let!(:listen_1) { FactoryGirl.create(:listen, user: user_1, audio: audio_1) }
    let!(:listen_2) { FactoryGirl.create(:listen, user: user_1, audio: audio_1) }
    let!(:listen_3) { FactoryGirl.create(:listen, user: user_1, audio: audio_2) }
    let!(:listen_4) { FactoryGirl.create(:listen, user: user_1, audio: audio_4) }
    let!(:listen_5) { FactoryGirl.create(:listen, user: user_2, audio: audio_4) }
    let!(:listen_6) { FactoryGirl.create(:listen, user: user_2, audio: audio_4) }
    let!(:listen_7) { FactoryGirl.create(:listen, user: user_2, audio: audio_4) }
    let!(:listen_8) { FactoryGirl.create(:listen, user: user_2, audio: audio_3) }
    let!(:listen_9) { FactoryGirl.create(:listen, user: user_2, audio: audio_3) }
    let!(:listen_10) { FactoryGirl.create(:listen, user: user_2, audio: audio_3) }

    it "returns all approved audios" do
      expect(Audio.top.all?(&:approved?)).to be true
    end

    it { expect(audio_4.reload.listens_count).to eq(4) }

    it { expect(audio_3.reload.listens_count).to eq(3) }

    it { expect(audio_1.reload.listens_count).to eq(2) }

    it { expect(audio_2.reload.listens_count).to eq(1) }

    it "returns top audios in order" do
      expect(Audio.top[0]).to eq(audio_4)
      expect(Audio.top[1]).to eq(audio_3)
      expect(Audio.top[2]).to eq(audio_1)
      expect(Audio.top[3]).to eq(audio_2)
    end
  end
end
