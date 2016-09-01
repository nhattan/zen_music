require "rails_helper"

RSpec.describe Category, :type => :model do
  let(:category) { FactoryGirl.create(:category) }

  it "returns placeholder image if thumbnail does not exist" do
    expect(category.thumbnail_url(:medium)).to eq "https://placehold.it/414x114"
    expect(category.thumbnail_url(:small)).to eq "https://placehold.it/375x114"
    expect(category.thumbnail_url(:smaller)).to eq "https://placehold.it/320x114"
    expect(category.thumbnail_url).to eq "https://placehold.it/414x114"
  end
end
