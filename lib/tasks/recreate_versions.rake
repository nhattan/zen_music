namespace :db do
  task recreate_category_thumbnail_versions: [:environment] do
    Category.find_each do |category|
      puts "Recreate category thumbnail versions"
      category.thumbnail.recreate_versions! if category.thumbnail?
    end
  end
end
