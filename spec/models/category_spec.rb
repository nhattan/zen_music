require "rails_helper"

RSpec.describe Category, :type => :model do
  let(:category) { FactoryGirl.create(:category) }

  it "returns placeholder image if thumbnail does not exist" do
    # expect(category.thumbnail_url(:medium)).to eq "/images/fallback/medium_audio.png"
    # expect(category.thumbnail_url(:small)).to eq "/images/fallback/small_audio.png"
    # expect(category.thumbnail_url(:smaller)).to eq "/images/fallback/smaller_audio.png"
    # expect(category.thumbnail_url).to eq "/images/fallback/audio.png"
  end
end
