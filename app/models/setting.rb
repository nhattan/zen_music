# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join("config/app.yml")
  namespace Rails.env

  class << self
    def save_values options = {}
      type_cast options
      options.each do |key, value|
        Setting.send "#{key.to_sym}=", value
      end
    end

    def type_cast options = {}
      %i(
        top_audio_quantity
        price
        admin_per_page
      ).each do |key|
        options[key] = options[key].to_i unless options[key].nil?
      end
    end
  end
end
