namespace :db do
  task recreate_category_thumbnail_versions: [:environment] do
    puts "Recreate category thumbnail versions"
    Category.find_each do |category|
      category.thumbnail.recreate_versions! if category.thumbnail?
    end
  end
end
