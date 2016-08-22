namespace :db do
  task update_user_role: [:environment] do
    puts "Update user role"
    User.where(admin: true).update_all(role: 2)
  end
end
