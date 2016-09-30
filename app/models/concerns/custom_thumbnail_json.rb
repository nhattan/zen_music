module CustomThumbnailJson
  extend ActiveSupport::Concerns

  def thumbnails
    {
      original: { url: thumbnail.url },
      medium: { url: thumbnail.url(:medium) },
      small: { url: thumbnail.url(:small) },
      smaller: { url: thumbnail.url(:smaller) }
    }
  end

  def as_json(options = nil)
    options ||= {}
    options.merge!(except: [:thumbnail, :uploaded_file], methods: [:uploaded_file_url, :thumbnails])
    super options
  end
end
