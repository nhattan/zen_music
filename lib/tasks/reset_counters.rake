namespace :db do
  task reset_listens_count: :environment do
    puts 'reset listens count'
    Audio.find_each { |audio| Audio.reset_counters(audio.id, :listens) }
  end

  task reset_likes_count: :environment do
    puts 'reset likes count'
    Audio.find_each { |audio| Audio.reset_counters(audio.id, :likes) }
  end
end
