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

  describe "#favorite_audios" do
    let!(:like_1) { FactoryGirl.create(:like, user: user_1, audio: audio_1) }
    let!(:like_2) { FactoryGirl.create(:like, user: user_1, audio: audio_2) }
    let!(:like_3) { FactoryGirl.create(:like, user: user_1, audio: audio_3) }
    let!(:like_4) { FactoryGirl.create(:like, user: user_1, audio: audio_4) }
    let!(:like_5) { FactoryGirl.create(:like, user: user_2, audio: audio_5) }

    it "returns all approved audios" do
      expect(user_1.favorite_audios.all?(&:approved?)).to be true
    end

    it { expect(user_1.favorite_audios.ids).to eq([audio_1, audio_2, audio_3, audio_4].map(&:id))}
  end

  describe "#activities" do
    let!(:like) { FactoryGirl.create(:like, audio: audio_1, user: user_1) }
    let!(:listen) { FactoryGirl.create(:listen, audio: audio_1, user: user_1) }

    it { expect(audio_1.activities).to eq user_1.activities }
  end
end
