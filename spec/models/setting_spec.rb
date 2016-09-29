require "rails_helper"

RSpec.describe Setting, :type => :model do
  let(:options) {
    {
      "app_name" => "Mid Brain Master",
      "top_audio_quantity" => "10",
      "price" => "200000",
      "admin_per_page" => nil,
    }
  }

  describe ".save_values" do
    before do
      Setting.save_values options
    end
    it "casts app_name as string" do
      expect(Setting.app_name).to eq("Mid Brain Master")
    end
    it "casts top_audio_quantity as integer" do
      expect(Setting.top_audio_quantity).to eq(10)
    end
    it "casts price as integer" do
      expect(Setting.price).to eq(200000)
    end
    it "does not cast admin_per_page" do
      expect(Setting.admin_per_page).to eq(nil)
    end
  end
end
