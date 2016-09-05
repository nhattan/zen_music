json.success true
json.data do
  json.category do
    json.id @category.id
    json.name @category.name
    json.description @category.description
    json.limited_access @category.limited_access
    json.created_at @category.created_at
    json.updated_at @category.updated_at
    json.parent_id @category.parent_id
    json.thumbnails @category.thumbnails
    json.audios @category.approved_audios
  end
end
