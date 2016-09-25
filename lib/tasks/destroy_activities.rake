namespace :db do
  task destroy_likes: :environment do
    puts "Destroy likes"
    likes = Like.select{|like| like.audio.nil?}
    likes.map(&:destroy)

    like_ids = Activity.likes.pluck :subject_id
    likes = Like.where.not(id: like_ids)
    likes.destroy_all
  end

  task destroy_listens: :environment do
    puts "Destroy listens"
    listens = Listen.select{|listen| listen.audio.nil?}
    listens.map(&:destroy)

    listen_ids = Activity.listens.pluck :subject_id
    listens = Listen.where.not(id: listen_ids)
    listens.destroy_all
  end

  task destroy_activities: :environment do
    puts "Destroy activities"
    user_ids = User.only_deleted.ids
    activity_with_deleted_user = Activity.where(user_id: user_ids)
    activity_with_deleted_subject = Activity.select{ |activity| activity.subject.nil? || activity.subject.audio.nil? }
    activity_ids = (activity_with_deleted_user.ids + activity_with_deleted_subject.map(&:id)).uniq
    activities = Activity.where(id: activity_ids)
    activities.destroy_all
  end
end
