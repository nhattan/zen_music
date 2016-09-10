FactoryGirl.define do
  factory :audio do
    name { Faker::Name.name }
    category
    uploaded_file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/audios/Russian Sherele.mp3')))
  end
end
