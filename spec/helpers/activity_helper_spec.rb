require "rails_helper"

RSpec.describe ActivityHelper, :type => :helper do
  describe "#color_class_by_day" do
    it do
      monday = Date.today.beginning_of_week
      expect(helper.color_class_by_day(monday)).to eq "bg-green"
    end
    it do
      tuesday = Date.today.beginning_of_week.advance days: 1
      expect(helper.color_class_by_day(tuesday)).to eq "bg-blue"
    end
    it do
      wednesday = Date.today.beginning_of_week.advance days: 2
      expect(helper.color_class_by_day(wednesday)).to eq "bg-aqua"
    end
    it do
      thursday = Date.today.beginning_of_week.advance days: 3
      expect(helper.color_class_by_day(thursday)).to eq "bg-yellow"
    end
    it do
      friday = Date.today.beginning_of_week.advance days: 4
      expect(helper.color_class_by_day(friday)).to eq "bg-orange"
    end
    it do
      saturday = Date.today.beginning_of_week.advance days: 5
      expect(helper.color_class_by_day(saturday)).to eq "bg-maroon"
    end
    it do
      sunday = Date.today.end_of_week
      expect(helper.color_class_by_day(sunday)).to eq "bg-red"
    end
  end
end
